# Log sorter

This script reads a file with logs following format:
```
/about 235.313.352.950
/contact 200.017.277.774
/about 836.973.694.403
```

And prints how many unique views page have. Uniqueness is determined by unique ip.

Example output:
```
/about 2 unique view(s)
/contact 1 unique view(s)
```

# Installation

## Requirements

1. Ruby version 2.7.0

## Steps

1. Clone this repository
2. Run bundler:
```
bundle
```

# Execution

```
ruby bin/parser.rb PATH_TO_YOUR_FILE
```

### Execute example:
```
ruby bin/parser.rb spec/files/webserver.log
```

# Tests

```
rspec
```

# Details

A script reads file line by line and stores each path in hash where key is path and value is set of ips. When path already added we add ip to already existing set of ips of current path.

Then we sort each pair (key, value) by count of ips and print result.

# Improvements

1. Add tests for bin/parser.rb
2. Add validations for file (missing file, wrong file, etc.)
3. Don't store ips in memory if not specified.
4. Add `--help` parameter
5. Process custom exstensions in the top of app. Create Parent custom exception and use existing.
