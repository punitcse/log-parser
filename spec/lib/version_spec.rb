# frozen_string_literal: true

require_relative '../spec_helper'

describe Parser::Version do
  let(:semver_regex) do
    /^([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?(?:\+[0-9A-Za-z-]+)?$/
  end

  it 'version is semantic' do
    expect(described_class::VERSION).to match(semver_regex)
  end
end
