# frozen_string_literal: true

require 'spec_helper'

describe Fetcher do
  subject(:fetcher) { Fetcher.new(url: url, http_adapter: httparty_mock) }

  let(:httparty_mock) { class_double('HTTParty') }
  let(:url) { 'some_url' }
  let(:content) { 'some_content' }

  describe '#fetch' do
    before do
      allow(httparty_mock).to receive(:get).with(url).and_return(content)
    end

    it 'must call get with provided url on adapter' do
      expect(httparty_mock).to receive(:get).with(url)

      fetcher.fetch
    end

    it 'must return result of fetching' do
      expect(fetcher.fetch).to eq(content)
    end
  end
end
