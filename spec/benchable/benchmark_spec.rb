# frozen_string_literal: true

require_relative "../spec_helper"

RSpec.describe Benchable::Benchmark do
  subject(:benchmark) { described_class.new(:bm) }

  it "has a setup method" do
    expect { benchmark.setup }.not_to raise_error
  end

  it "has a run method" do
    expect { benchmark.run }.not_to raise_error
  end

  it "has benchmark cases" do
    expect(benchmark.cases).to eq []
  end

  context "with an invalid benchmark type" do
    subject(:invalid_benchmark) { described_class.new(:invalid) }

    it "raises an exception" do
      expect { invalid_benchmark }.to raise_error Benchable::Error, "Invalid benchmark type 'invalid'"
    end
  end

  describe ".setup" do
    let(:klass) { Class.new(described_class) }

    before do
      klass.setup { puts "New setup" }
    end

    it "creates a new setup method" do
      expect { klass.new(:bm).setup }.to output("New setup\n").to_stdout
    end
  end

  describe ".bench" do
    let(:klass) { Class.new(described_class) }

    before do
      klass.bench("The puts method") do
        puts "Hello world!"
      end
    end

    it "creates a new bench method" do
      expect { klass.new(:bm).bench_the_puts_method }.to output("Hello world!\n").to_stdout
    end
  end
end
