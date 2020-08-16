# frozen_string_literal: true

require_relative 'benchable/benchmark'
require_relative 'benchable/version'

module Benchable
  class Error < StandardError; end

  def self.build(type = :bm, options, &block)
    Benchmark.class_eval(&block)

    Benchmark.new(type, **options)
  end

  def self.bench(type = :bm, options, &block)
    build(type, options, &block).run
  end
end
