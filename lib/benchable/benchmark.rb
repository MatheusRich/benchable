# frozen_string_literal: true

module Benchable
  class Benchmark
    def initialize
      @cases = []
    end

    def setup; end

    def run; end

    def cases
      public_methods.grep(/\Abench_/)
    end
  end
end
