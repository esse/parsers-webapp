# frozen_string_literal: true

require 'spec_helper'

describe Dataset do
  subject(:dataset) do
    Dataset.new(array, date: date_mock)
  end

  let(:date_mock) { class_double('Date') }

  describe '#filter_by_name' do
    it 'must select good records from array and return new dataset with them' do
    end
  end

  describe '#filter_by_date' do
    xit 'must select good records from array and return new dataset with them' do
    end
  end

  describe '#filter_by_source' do
    xit 'must select good records from array and return new dataset with them' do
    end
  end
end
