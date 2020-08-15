# frozen_string_literal: true

require_relative 'benchable/benchmark'
require_relative 'benchable/version'

module Benchable
  class Error < StandardError; end

  def self.build(&block)
    bench = Benchmark.new

    bench.instance_exec(&block)

    bench
  end
end
