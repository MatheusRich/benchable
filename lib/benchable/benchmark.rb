# frozen_string_literal: true

require 'benchmark'
require 'benchmark/ips'

module Benchable
  class Benchmark
    DEFAULT_WIDTH = 20

    def initialize(type, options = {})
      @benchmark_type = type
      @options = options
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
