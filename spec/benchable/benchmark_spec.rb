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

  describe '.setup' do
    before do
      described_class.setup { puts 'New setup' }
    end

    it 'creates a new setup method' do
      expect { described_class.new(:bm).setup }.to output("New setup\n").to_stdout
    end
  end

  describe '.bench' do
    before do
      described_class.bench('The puts method') do
        puts 'Hello world!'
      end
    end

    it 'creates a new bench method' do
      expect { described_class.new(:bm).bench_the_puts_method }.to output("Hello world!\n").to_stdout
    end
  end
end
