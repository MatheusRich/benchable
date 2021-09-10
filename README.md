<p align="center">
  <h1 align="center">Benchable</h1>

  <p align="center">
    <i>Write benchmarks without the hassle.</i>
    <br>
    <br>
    <img src="https://img.shields.io/gem/v/benchable">
    <img src="https://img.shields.io/gem/dt/benchable">
    <img src="https://github.com/MatheusRich/benchable/workflows/Ruby/badge.svg">
    <a href="https://github.com/MatheusRich/benchable/blob/master/LICENSE">
      <img src="https://img.shields.io/github/license/MatheusRich/benchable.svg" alt="License">
    </a>
  </p>
</p>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'benchable'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install benchable

## Usage
### Basic usage
Use the method `Benchable.bench` to declare a benchmark. Write each benchmark case with the `bench` method. The benchmark will run automatically.

```ruby
Benchable.bench do
  bench 'sort' do
    (1..1000000).map { rand }.sort
  end

  bench 'sort!' do
    (1..1000000).map { rand }.sort!
  end
end
# Output:
#                            user     system      total        real
# Sort                   0.483720   0.003975   0.487695 (  0.487695)
# Sort!                  0.477415   0.000009   0.477424 (  0.477409)
```

You can write a setup method to DRY up any logic.

**Important:** The setup method runs **only once** before **all** benchs, so be careful with mutation inside your benchs.

```ruby
Benchable.bench do
  setup do
    @array = (1..1000000).map { rand }
  end

  bench 'sort' do
    @array.dup.sort
  end

  bench 'sort!' do
    @array.dup.sort!
  end
end
# Output:
#                            user     system      total        real
# Sort                   0.400133   0.011995   0.412128 (  0.412339)
# Sort!                  0.388636   0.003980   0.392616 (  0.393054)
```
> We've used `Array#dup` in the example above to prevent the benchmarks for modifying the original array

### Benchmark types
There are 4 benchmark types available: `bm`, `bmbm`, `ips` and `memory`. You can specify the type by passing it as a symbol on the `Benchable.bench` method. The default type is `bm`.

```ruby
Benchable.bench(:bm) do
  # ...
end

Benchable.bench(:bmbm) do
  # ...
end

Benchable.bench(:ips) do
  # ...
end

Benchable.bench(:memory) do
  # ...
end
```

Given an invalid benchmark type, Benchable will raise an exception.

```ruby
Benchable.bench(:invalid) do
  # ...
end
# => Benchable::Error (Invalid benchmark type 'invalid')
```

### Benchmark options
You can provide benchmark options by passing a hash to the `Benchable.bench` method.

#### Options for `Benchmark.bm` and `Benchmark.bmbm`
On `bm` and `bmbm` benchmarks the only available option is `width`, which specifies the leading spaces for labels on each line. The default width is `20`.

```ruby
Benchable.bench(width: 25) do
  # ...
end
```

#### Options for `Benchmark::IPS`
If you're using `::IPS`, you can pass any option accepted by `Benchmark::IPS`' `config` method.

```ruby
Benchable.bench(:ips, time: 5, warmup: 2) do
  # ...
end
# Output:
# Warming up --------------------------------------
#                 Sort     1.000  i/100ms
#                Sort!     1.000  i/100ms
# Calculating -------------------------------------
#                 Sort      2.114  (± 0.0%) i/s -     11.000  in   5.205127s
#                Sort!      2.120  (± 0.0%) i/s -     11.000  in   5.189772s
```

#### Options for `Benchmark::Memory`
You can pass [any option accepted](https://github.com/michaelherold/benchmark-memory#options) by `Benchmark::Memory`.

```ruby
Benchable.bench(:memory, quiet: true) do
  # ...
end
# Output:
# => #<Benchmark::Memory::Report:0x0000558cdfdbc498 ...>

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MatheusRich/benchable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/MatheusRich/benchable/blob/master/CODE_OF_CONDUCT.md).


## Acknowledgments
Thanks [@naomik](https://github.com/naomik) for building the base idea for this in [his gist](https://gist.github.com/naomik/6012505)!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Benchable project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/MatheusRich/benchable/blob/master/CODE_OF_CONDUCT.md).
