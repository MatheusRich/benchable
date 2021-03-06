# frozen_string_literal: true

require_relative 'benchable/benchmark'
require_relative 'benchable/version'

# The Benchable library is used for automating benchmarks
module Benchable
  class Error < StandardError; end

  def self.build(type = :bm, **options, &block)
    bench_class = Class.new(Benchmark, &block)

    bench_class.new(type, **options)
  end

  def self.bench(type = :bm, **options, &block)
    build(type, **options, &block).run
  end
end
