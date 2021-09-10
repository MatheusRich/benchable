# frozen_string_literal: true

require_relative "benchable/benchmark"
require_relative "benchable/version"

# Benchable is used for automating benchmarks
module Benchable
  class Error < StandardError; end

  class << self
    def build(type = :bm, **options, &block)
      bench_class = Class.new(Benchmark, &block)

      bench_class.new(type, **options)
    end

    def bench(*types, **options, &block)
      types << :bm if types.empty?

      types.map { |type| build(type, **options, &block).run }
    end
    ruby2_keywords :bench if respond_to?(:ruby2_keywords, true)
  end
end
