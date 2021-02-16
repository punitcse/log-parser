# frozen_string_literal: true

require_relative '../../spec_helper'

describe Parser::PageCounter do
  it 'returns blank array when no log present' do
    content = {}
    expect(described_class.new(content).count).to be_empty
  end

  let(:content) do
    {
      '/help_page' => {
        '126.318.035.038' => { count: 3 },
        '184.123.665.067' => { count: 5 },
        '184.123.665.068' => { count: 1 }
      },
      '/home' => {
        '184.123.665.067' => { count: 2 },
        '123.123.665.068' => { count: 28 }
      },
      '/about/1' => {
        '126.318.035.038' => { count: 5 }
      }
    }
  end

  subject { described_class.new(content) }

  it 'count the number of page view and sort them and sort them in descending order' do
    expect(subject.count).to eq([
                                  { page: '/home', count: 30 },
                                  { page: '/help_page', count: 9 },
                                  { page: '/about/1', count: 5 }
                                ])
  end

  it 'count the number of unique page view and sort them in descending order' do
    expect(subject.count(unique_ip: true)).to eq([
                                                   { page: '/help_page', count: 3 },
                                                   { page: '/home', count: 2 },
                                                   { page: '/about/1', count: 1 }
                                                 ])
  end
end
