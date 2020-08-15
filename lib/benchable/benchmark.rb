# frozen_string_literal: true

require 'benchmark'
require 'benchmark/ips'

module Benchable
  class Benchmark
    def initialize(type, options = {})
      @benchmark_type = type
      @options = options
    end

    def setup; end

    def run
      setup
      run_benchmark
    end

    def cases
      public_methods.grep(/\Abench_/)
    end

    private

    def run_benchmark
      benchmark do |with|
        with.config(**@options) if @benchmark_type == :ips

        cases.each do |benchmark_case|
          with.report(name_for(benchmark_case)) do
            method(benchmark_case).call
          end
        end
      end
    end

    def name_for(benchmark_case)
      benchmark_case.to_s.gsub('bench_', '').gsub('_', ' ').capitalize
    end

    def benchmark(&block)
      ::Benchmark.public_send(@benchmark_type, 20, &block)
    end
  end
end
