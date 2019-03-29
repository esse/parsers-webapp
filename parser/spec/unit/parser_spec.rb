# frozen_string_literal: true

require 'spec_helper'

describe Parser do
  subject(:parser) do
    Parser.new(
      source: source, html: html,
      pipeline: pipeline_mock, nokogiri_html: nokogiri_html_mock
    )
  end

  let(:source) do
    {
      'list' => list_instruction,
      'xpaths' => xpaths_instructions,
    }
  end
  let(:html) { "X" }
  let(:parsed_html) { "parsed x" }
  let(:pipeline_mock) { class_double('Pipeline') }
  let(:nokogiri_html_mock) { class_double('Nokogiri::HTML') }
  let(:list_instruction) { "some_instruction" }
  let(:xpaths_instructions) { [] }
  let(:parsed_event) { "some parsed event data"}
  let(:event_lists) { [] }

  let(:list_pipeline) { instance_double('Pipeline') }

  before do
    allow(pipeline_mock)
      .to receive(:new)
      .with(instructions: list_instruction, parsed_html: parsed_html)
      .and_return(list_pipeline)
    allow(list_pipeline).to receive(:process).and_return(event_lists)
    allow(nokogiri_html_mock).to receive(:parse).with(html).and_return(parsed_html)
  end

  describe '#parse' do
    it 'works' do
      parser.parse
    end
  end
end
