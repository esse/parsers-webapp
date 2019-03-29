require "spec_helper"

require_relative "../../app"

describe Command do
  subject(:command) { Command.new(instruction: instruction,  nodes: nodes) }

  let(:nodes) { instance_double('Nokogiri::XML::NodeSet') }

  describe '#run' do
    describe 'instruction xpath' do
      let(:instruction) do
        {
          "operand" => "xpath",
          "argument" => xpath
        }
      end
      let(:xpath) { 'some_xpath' }
      let(:result) { "some_output" }

      before do
        allow(nodes).to receive(:xpath).and_return(result)
      end

      it "must call xpath method on nodes" do
        expect(nodes).to receive(:xpath).and_return(result)
        command.run
      end

      it "must return result of xpath command" do
        expect(command.run).to eq(result)
      end
    end

    describe 'instruction inner_html' do
      let(:instruction) do
        {
          "operand" => "inner_html"
        }
      end
      let(:result) { 'some_output' }

      before do
        allow(nodes).to receive(:inner_html).and_return(result)
      end

      it "must call inner_html method on nodes" do
        expect(nodes).to receive(:inner_html).and_return(result)
        command.run
      end

      it "must return result of inner_html command" do
        expect(command.run).to eq(result)
      end
    end

    describe 'instruction constant' do
      let(:instruction) do
        {
          "operand" => "constant",
          "argument" => const
        }
      end
      let(:const) { 'some_constant' }

      it 'must return argument' do
        expect(command.run).to eq(const)
      end
    end

  end

end
