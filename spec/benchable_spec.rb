# frozen_string_literal: true

require_relative "./spec_helper"

RSpec.describe Benchable do
  it "has a version number" do
    expect(Benchable::VERSION).not_to be nil
  end

  describe ".build" do
    subject(:build_benchmark) do
      described_class.build(:ips, time: 0.2, warmup: 0.1) do
        setup do
          puts "Setting up..."
        end

        bench "sum" do
          1 + 1
        end

        def bench_sum_with_send
          1.send(:+, 1)
        end

        def an_invalid_bench_method
        end
      end
    end

    it "builds a benchmark" do
      expect(build_benchmark).to be_a Benchable::Benchmark
    end

    it "overrides the setup method" do
      expect { build_benchmark.setup }.to output("Setting up...\n").to_stdout
    end

    it "defines benchmark cases" do
      expect(build_benchmark.cases).to match_array %i[bench_sum bench_sum_with_send]
    end

    it "accepts options without defining a benchmark type" do
      expect { described_class.build(width: 1) }.not_to raise_error
    end
  end

  describe ".bench" do
    subject(:run_benchmark) do
      described_class.bench(:ips, warmup: 0, time: 0.1) do
        bench "sum" do
          1 + 1
        end

        bench "multiplication" do
          1 * 1
        end
      end
    end

    let(:bench_mock) { instance_double(Benchmark::IPS::Job) }

    before do
      allow(bench_mock).to receive(:config)
      allow(bench_mock).to receive(:compare!)
      allow(bench_mock).to receive(:report).with("Sum").and_yield
      allow(bench_mock).to receive(:report).with("Multiplication").and_yield
      allow(Benchmark).to receive(:ips).and_yield(bench_mock)
    end

    it "configures IPS benchmarks" do
      run_benchmark

      expect(bench_mock).to have_received(:config).with(warmup: 0, time: 0.1)
    end

    it "builds and runs a benchmark", :aggregate_failures do
      run_benchmark

      expect(bench_mock).to have_received(:report).with("Sum")
      expect(bench_mock).to have_received(:report).with("Multiplication")
      expect(bench_mock).to have_received(:compare!)
    end

    context "when multiple benchmark types are given" do
      it "builds and runs one bechmark for each type" do
        dummy_bench = instance_double(Benchable::Benchmark, run: true)
        allow(Benchable).to receive(:build).with(:ips, warmup: 0, time: 0.1).and_return(dummy_bench)
        allow(Benchable).to receive(:build).with(:bm, warmup: 0, time: 0.1).and_return(dummy_bench)

        described_class.bench(:ips, :bm, warmup: 0, time: 0.1) do
          bench "sum" do
            1 + 1
          end

          bench "multiplication" do
            1 * 1
          end
        end

        expect(dummy_bench).to have_received(:run).twice
        expect(Benchable).to have_received(:build).with(:ips, warmup: 0, time: 0.1)
        expect(Benchable).to have_received(:build).with(:bm, warmup: 0, time: 0.1)
      end
    end

    context "when no benchmark type is given" do
      it "defaults to bm benchmark" do
        dummy_bench = instance_double(Benchable::Benchmark, run: true)
        allow(Benchable).to receive(:build).with(:bm, {}).and_return(dummy_bench)

        described_class.bench do
          bench "sum" do
            1 + 1
          end

          bench "multiplication" do
            1 * 1
          end
        end

        expect(Benchable).to have_received(:build).with(:bm, {})
        expect(dummy_bench).to have_received(:run)
      end
    end
  end
end
