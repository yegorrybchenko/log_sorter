# Log sorter

![main workflow](https://github.com/yegorrybchenko/log_sorter/actions/workflows/main.yml/badge.svg)

This script reads a file with logs following format:

```bash
/about 235.313.352.950
/contact 200.017.277.774
/about 136.973.694.403
/about 136.973.694.403
```

And prints how many total and unique views page have, sorted in desc ordering by count. Uniqueness is determined by unique ip.

Example output:

```bash
Most viewed pages:
/about has 3 view(s)
/contact has 1 view(s)

Pages with most unique views:
/about 2 unique view(s)
/contact 1 unique view(s)
```

## Installation

## Requirements

1. Ruby version 2.7.0

### Steps

1. Clone this repository
2. Run bundler:

```bash
bundle
```

## Execution

```bash
ruby bin/sorter.rb PATH_TO_YOUR_FILE
```

### Execute example

```bash
ruby bin/sorter.rb spec/files/webserver.log
```

## Tests

```bash
rspec
```

## Details

A script reads file line by line and stores each path in hash where key is path and value is hash ip => count, where count is count of that ip for current page path. When path already added we add ip to already existing hash. When ip is already added we increments ip count.

Then we sort each pair (key, value) by count of ips and print result.

## Improvements

1. Add tests for bin/sorter.rb
2. Add validations for file (missing file, wrong file, etc.)
3. Add `--help` parameter
4. Process custom exstensions in the top of app. Create Parent custom exception and use existing.
