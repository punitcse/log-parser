# frozen_string_literal: true

require_relative '../../spec_helper'

describe Parser::View do
  subject { described_class.new }

  describe '#render' do
    it 'all the page visits' do
      response = [
        { page: '/home', count: 30 },
        { page: '/about', count: 10 }
      ]
      expect(subject).to receive(:render_line).with('/home', 30, unique: false)
      expect(subject).to receive(:render_line).with('/about', 10, unique: false)
      subject.render(response)
    end

    it 'only unique page visits' do
      response = [
        { page: '/home', count: 3 },
        { page: '/contact', count: 2 }
      ]
      expect(subject).to receive(:render_line).with('/home', 3, unique: true)
      expect(subject).to receive(:render_line).with('/contact', 2, unique: true)
      subject.render(response, unique: true)
    end
  end

  describe '#render_line' do
    it 'prints the line for page view' do
      expect($stdout).to receive(:puts).with('/contact 32 visits')
      subject.render_line('/contact', 32)
    end

    it 'prints the line unique page view' do
      expect($stdout).to receive(:puts).with('/home 3 unique views')
      subject.render_line('/home', 3, unique: true)
    end
  end
end
