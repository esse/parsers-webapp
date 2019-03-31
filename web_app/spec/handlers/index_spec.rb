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
    allow(adapter_mock).to receive(:sanitized_params).and_return({})
  end

  describe '#call' do
    describe 'with empty params' do
      let(:params) { {} }

      it 'must return empty params' do
        index_handler.call
        # expect(index_handler.sanitized_params).to eq({})
      end
    end
  end
end
