# frozen_string_literal: true

require 'benchmark'
require 'benchmark/ips'

module Benchable
  class Benchmark
    DEFAULT_WIDTH = 20
    BENCHMARK_TYPES = %i[bm bmbm ips].freeze

    def initialize(benchmark_type, options = {})
      @benchmark_type = benchmark_type
      @options = options

      raise Error, "Invalid benchmark type '#{benchmark_type}'" unless valid_benchmark_type?
    end

    def self.setup(&block)
      define_method(:setup, &block)
    end

    def self.bench(name = '', &block)
      define_method(method_name_for(name), &block)
    end

    def setup; end

    def run
      setup
      run_benchmark
    end

    def cases
      public_methods.grep(/\Abench_/)
    end

    private_class_method def self.method_name_for(name)
      "bench_#{name.to_s.gsub(' ', '_').downcase}"
    end

    private

    attr_reader :benchmark_type, :options

    def valid_benchmark_type?
      BENCHMARK_TYPES.include? benchmark_type
    end

    def run_benchmark
      benchmark do |with|
        with.config(**options) if benchmark_type == :ips

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
      width = options[:width] || DEFAULT_WIDTH

      ::Benchmark.public_send(benchmark_type, width, &block)
    end
  end
end
