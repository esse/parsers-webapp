# frozen_string_literal: true

require 'spec_helper'

describe Adapters::Index do
  subject(:index_adapter) { Adapters::Index.new(params: params) }

  describe '#sanitized_params' do
    describe 'with empty params' do
      let(:params) { {} }

      it 'must return empty params' do
        expect(index_adapter.sanitized_params).to eq({})
      end
    end

    describe 'with one of the paramters blank' do
      let(:params) { { name: '' } }

      it 'must filter it' do
        expect(index_adapter.sanitized_params).to eq({})
      end
    end

    describe 'with extra parameter' do
      let(:params) { { XXX: 'YYY' } }

      it 'must filter it' do
        expect(index_adapter.sanitized_params).to eq({})
      end
    end

    describe 'with correct param' do
      let(:params) { { name: 'event' } }

      it 'must pass it through' do
        expect(index_adapter.sanitized_params).to eq(name: 'event')
      end
    end
  end
end
