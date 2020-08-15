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

    it 'does something' do
      build_benchmark.run
    end
  end
end
