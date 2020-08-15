# frozen_string_literal: true

module Benchable
  class Benchmark
    attr_reader :cases

    def initialize
      @cases = []
    end

    def setup; end

    def run; end
  end
end
