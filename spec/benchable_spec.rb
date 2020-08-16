# frozen_string_literal: true

require_relative './spec_helper'

RSpec.describe Benchable do
  it 'has a version number' do
    expect(Benchable::VERSION).not_to be nil
  end

  describe '.build' do
    subject(:build_benchmark) do
      described_class.build(:ips, time: 0.2, warmup: 0.1) do
        def setup
          puts 'Setting up...'
        end

        def bench_sum
          1 + 1
        end

        def bench_sum_with_send
          1.send(:+, 1)
        end

        def an_invalid_bench_test; end
      end
    end

    it 'builds a benchmark' do
      expect(build_benchmark).to be_a Benchable::Benchmark
    end

    it 'overrides the setup method' do
      expect { build_benchmark.setup }.to output("Setting up...\n").to_stdout
    end

    it 'defines benchmark cases' do
      expect(build_benchmark.cases).to match_array %i[bench_sum bench_sum_with_send]
    end

    it 'accepts options without defining a benchmark type' do
      expect { described_class.build(width: 1) }.not_to raise_error
    end
  end

  describe '.bench' do
    subject(:run_benchmark) do
      described_class.bench
    end

    let(:bench_object) { instance_double(Benchable::Benchmark, run: true) }

    before do
      allow(described_class).to receive(:build).with(:bm, {}).and_return(bench_object)
    end

    it 'builds and runs a benchmark' do
      run_benchmark
      expect(bench_object).to have_received(:run)
    end
  end
end
