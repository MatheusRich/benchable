# frozen_string_literal: true

RSpec.describe Benchable do
  it 'has a version number' do
    expect(Benchable::VERSION).not_to be nil
  end

  describe '.build' do
    subject(:build_benchmark) do
      described_class.build do
        def setup
          puts 'Setting up...'
        end

        def bench_addition
          1 + 1
        end

        def bench_addition_with_send
          1.send(:+, 1)
        end

        def other; end
      end
    end

    it 'builds a benchmark' do
      expect(build_benchmark).to be_a Benchable::Benchmark
    end

    it 'overrides the setup method' do
      expect { build_benchmark.setup }.to output("Setting up...\n").to_stdout
    end

    it 'defines benchmark cases' do
      expect(build_benchmark.cases).to eq %i[bench_addition bench_addition_with_send]
    end
  end
end
