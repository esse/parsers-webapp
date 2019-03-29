require "spec_helper"

require_relative "../../app"

describe Command do
  subject(:command) { Command.new(instruction: instruction,  nodes: nodes) }

  let(:nodes) { instance_double('Object') }

  describe '#run' do
    describe 'instruction xpath' do
      it "must call xpath command on nodes"
    end

    describe 'instruction inner_html' do

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
