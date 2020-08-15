# frozen_string_literal: true

require_relative 'benchable/benchmark'
require_relative 'benchable/version'

module Benchable
  class Error < StandardError; end

  def self.build(type = :bm, options = {}, &block)
    bench = Benchmark.new(type, options)

    bench.instance_exec(&block)

    bench
  end

  def self.bench(*args, &block)
    build(*args, &block).run
  end
end
