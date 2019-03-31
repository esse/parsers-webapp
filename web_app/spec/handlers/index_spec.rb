# frozen_string_literal: true

require 'spec_helper'

describe Handlers::Index do
  subject(:index_handler) do
    Handlers::Index.new(
      params: params, database: database_mock,
      date: date_mock, adapter: adapter_class_mock
    )
  end

  let(:database_mock) { instance_double('Database') }
  let(:date_mock) { instance_double('Date') }
  let(:adapter_class_mock) { class_double('Adapters::Index') }
  let(:adapter_mock) { instance_double('Adapters::Index') }
  let(:dataset_mock) { instance_double('Dataset') }

  before do
    allow(database_mock).to receive(:dataset).and_return(dataset_mock)
    allow(adapter_class_mock).to receive(:new).and_return(adapter_mock)
    allow(adapter_mock).to receive(:sanitized_params).and_return(params)
  end

  describe '#locals' do

    describe 'with empty params' do
      let(:params) { {} }

      it 'must return not mutated dataset' do
        index_handler.call
        expect(index_handler.locals).to eq({ dataset: dataset_mock })
      end

      it 'must call sanitized_params on adapter' do
        expect(adapter_mock).to receive(:sanitized_params).and_return(params)
        index_handler.call
      end
    end

    describe 'when filtering with name' do
      let(:params) { {"name" => "XYZ"} }

      it 'must call filter_by_name on dataset' do
        expect(dataset_mock).to receive(:filter_by_name).and_return(dataset_mock)
        index_handler.call
      end
    end

    describe 'when filtering with source' do
      let(:params) { {"source" => "XYZ"} }

      it 'must call filter_by_source on dataset' do
        expect(dataset_mock).to receive(:filter_by_source).and_return(dataset_mock)
        index_handler.call
      end
    end

    # describe 'when filtering with date' do
    #   let(:params) { {date: "XYZ"} }

    #   it 'must return not mutated dataset' do
    #     expect(index_handler.locals).to eq({ dataset: dataset_mock })
    #   end
    # end
  end
end
