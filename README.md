# Benchable

Write benchmarks without the hassle.

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

```ruby
Benchable.bench do
  def setup
    @array = (1..1000000).map { rand }
  end

  def bench_sort
    @array.dup.sort 
  end

  def bench_sort!
    @array.dup.sort!
  end
end
# Output:
#                            user     system      total        real
# Sort                   0.400133   0.011995   0.412128 (  0.412339)
# Sort!                  0.388636   0.003980   0.392616 (  0.393054)
```

TODO:
```ruby
Benchable.bench(:ips, time: 5, warmup: 2) do
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
# Warming up --------------------------------------
#                 Sort     1.000  i/100ms
#                Sort!     1.000  i/100ms
# Calculating -------------------------------------
#                 Sort      2.496  (± 0.0%) i/s -     13.000  in   5.210732s
#                Sort!      2.428  (± 0.0%) i/s -     13.000  in   5.358355s
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MatheusRich/benchable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/MatheusRich/benchable/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Benchable project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/MatheusRich/benchable/blob/master/CODE_OF_CONDUCT.md).
