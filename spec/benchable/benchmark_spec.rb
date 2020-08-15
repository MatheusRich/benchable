# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Benchable::Benchmark do
  it 'has a setup method' do
    expect { described_class.new(:bm).setup }.not_to raise_error
  end

  it 'has a run method' do
    expect { described_class.new(:bm).run }.not_to raise_error
  end

  it 'has benchmark cases' do
    expect(described_class.new(:bm).cases).to eq []
  end
end
