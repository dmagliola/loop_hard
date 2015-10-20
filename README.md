# loop_hard

[![Build Status](https://travis-ci.org/dmagliola/loop_hard.svg?branch=master)](https://travis-ci.org/dmagliola/loop_hard)
[![Coverage Status](https://coveralls.io/repos/dmagliola/loop_hard/badge.svg?branch=master&service=github)](https://coveralls.io/github/dmagliola/loop_hard?branch=master)
[![Code Climate](https://codeclimate.com/github/dmagliola/loop_hard/badges/gpa.svg)](https://codeclimate.com/github/dmagliola/loop_hard)
[![Inline docs](http://inch-ci.org/github/dmagliola/loop_hard.svg?branch=master&style=flat)](http://inch-ci.org/github/dmagliola/loop_hard)
[![Gem Version](https://badge.fury.io/rb/loop_hard.png)](http://badge.fury.io/rb/loop_hard)

Add timeouts to your long-running loops, and response to signals gracefully.

LoopHard allows you to have long-running worker loops that will stop after a while,
and also stop if they get an external signal to stop (for example, if Sidekiq stops due to a USR1,
or a TERM signal is trapped).

Possible use cases:

- You have a background job that runs every 10 minutes and loops through a bunch of records until there are none left.
    Use `Hardloop.loop_for(9.5.minutes)` to generally prevent overlapping.
- You don't have a time limit, but you're running a long job inside Sidekiq, and you want to exit gracefully when
    Sidekiq decides it's terminating. You shouldn't have long-running jobs on Sidekiq, but hey! it happens!
- Same case as before, but not inside Sidekiq. You're either handling signals yourself, or have some other
    library (in which case, please do a PR!)

## Download

Gem:

`gem install loop_hard`

## Installation

Load the gem in your GemFile.

  `gem "loop_hard"`


## Loop Hard!

Replace your:

```
loop do
  # do stuff until we break
end
```

with

```
LoopHard.loop_for(10.minutes) do
  # do stuff until we break, or until 10 minutes go by, or until something tells us to stop
end
```

## Version Compatibility and Continuous Integration

Tested with [Travis](https://travis-ci.org/dmagliola/loop_hard) using Ruby 1.9.3, 2.0, 2.1.1, 2.1.5 and 2.2.2.

To locally run tests do:

```
rake test
```

## Copyright

Copyright (c) 2015, Daniel Magliola

See LICENSE for details.


## Users

This gem is being used by:

- [MSTY](https://www.msty.com)
- You? please, let us know if you are using this gem.


## Changelog

### Version 0.1.0 (Oct 20th, 2015)
- Newly released gem

## Contributing

1. Fork it
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Code your thing
1. Write and run tests:
        bundle install
        rake test
1. Write documentation and make sure it looks good: yard server --reload
1. Add items to the changelog, in README.
1. Commit your changes (`git commit -am "Add some feature"`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request
