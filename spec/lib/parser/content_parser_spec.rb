# frozen_string_literal: true

require_relative '../../spec_helper'

describe Parser::ContentParser do
  let(:content) do
    [
      '/help_page/1 126.318.035.038',
      '/home 184.123.665.067',
      '/home 197.123.665.067',
      '/home 123.123.231.111',
      '/home 184.123.665.067',
      '/about 126.318.035.038'
    ]
  end

  describe '#parse' do
    it 'return logs with page count, name and ip address' do
      logs = described_class.new(content).parse
      expect(logs.size).to eq(3)
      log_output = { '/help_page/1' => { '126.318.035.038' => { count: 1 } },
                     '/home' => { '184.123.665.067' => { count: 2 },
                                  '197.123.665.067' => { count: 1 },
                                  '123.123.231.111' => { count: 1 } },
                     '/about' => { '126.318.035.038' => { count: 1 } } }

      expect(logs).to eq(log_output)
    end

    it 'does not increase count if page are from different ip address' do
      content = [
        '/home 184.123.665.067',
        '/home 123.123.231.111',
        '/home 123.123.665.067'
      ]
      logs = described_class.new(content).parse
      expect(logs.size).to eq(1)
      expect(logs).to eq(
        '/home' => { '184.123.665.067' => { count: 1 },
                     '123.123.231.111' => { count: 1 },
                     '123.123.665.067' => { count: 1 } }
      )
    end

    it 'return the full URI for page name' do
      content = [
        '/otherpage/1/2/3/4 126.318.035.038'
      ]
      logs = described_class.new(content).parse
      expect(logs.size).to eq(1)
      expect(logs).to eq({ '/otherpage/1/2/3/4' => { '126.318.035.038' => { count: 1 } } })
    end

    it 'discard additional ip addresses in same line' do
      content = [
        '/home 184.123.665.067 184.123.665.067'
      ]
      logs = described_class.new(content).parse
      expect(logs.size).to eq(1)
      expect(logs).to eq({ '/home' => { '184.123.665.067' => { count: 1 } } })
    end

    it 'skip any empty line' do
      content = [
        '/home 184.123.665.067 184.123.665.067',
        '  '
      ]
      logs = described_class.new(content).parse
      expect(logs.size).to eq(1)
    end
  end
end
