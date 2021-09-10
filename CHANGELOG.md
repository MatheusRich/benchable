# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Allow running multiple benchmarks at once:

```ruby
Benchable.bench(:ips, :memory) do
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
```

### Changed

- Compare benchmarks after running them 🤦‍♂️.
<!-- ### Removed -->
---

## [0.2.0] - 2020-10-23

### Added
- Support for `Benchmark.memory` via [benchmark-memory](https://github.com/michaelherold/benchmark-memory).

[unreleased]: https://github.com/MatheusRich/benchable/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/MatheusRich/benchable/releases/tag/v0.2.0

## [0.1.0] - 2020-08-16

### Added
- Support for `Benchmark.bm`, `Benchmark.bmbm` and `Benchmark.ips`.

[unreleased]: https://github.com/MatheusRich/benchable/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/MatheusRich/benchable/releases/tag/v0.1.0