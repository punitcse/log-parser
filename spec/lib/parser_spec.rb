# frozen_string_literal: true

require_relative '../spec_helper'

describe Parser do
  describe '.call' do
    let(:path) { "#{RSPEC_ROOT}/fixtures/files/test.log" }

    subject { Parser.call(path) }

    context 'for invalid path' do
      let(:path) { 'abc/def' }

      it 'raises file not found' do
        expect { subject }.to raise_exception(Parser::LogFile::FileNotFound)
      end
    end

    context 'for valid file path' do
      let(:content) do
        [{ count: 3, page: '/help_page/1' }, { count: 2, page: '/home' },
         { count: 1, page: '/about/2' }]
      end

      let(:unique_content) do
        [{ count: 2, page: '/help_page/1' }, { count: 1, page: '/home' },
         { count: 1, page: '/about/2' }]
      end

      it 'print all the page visits and unique views' do
        view = instance_double(Parser::View)

        allow(Parser::View).to receive(:new).and_return(view)

        expect(view).to receive(:render).with(content)
        expect(view).to receive(:render).with(unique_content, unique: true)

        Parser.call(path)
      end
    end
  end
end
