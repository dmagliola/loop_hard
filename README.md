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
    Use `LoopHard.loop(timeout: 9.5.minutes)` to generally prevent overlapping.
- You don't have a time limit, but you're running a long job inside Sidekiq, and you want to exit gracefully when
    Sidekiq decides it's terminating (and before Heroku kills the process!).
    You shouldn't have long-running jobs on Sidekiq, but hey! it happens!
- Same case as before, but not inside Sidekiq. You're either handling signals yourself, or have some other
    library (in which case, please do a PR!)

The assumption is, obviously, that your loop will run for a long time, but each iteration of your loop is going to be
quick, otherwise, we can't really exit gracefully. But if we do exit gracefully, you know you're exiting in a known state.

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
LoopHard.loop(timeout: 10.minutes) do
  # do stuff until we break, or until 10 minutes go by, or until something tells us to stop
end
```

or, don't really specify a timeout if you're going to run forever, but just want to trap signals / Sidekiq shutdown
gracefully.

### Set your Logger

LoopHard logs to LoopHard.logger every time it exits a loop, since normally these aren't normal conditions and you
might want to be notified about it. By default, it logs to stdout.

You probably want to set it to `LoopHard.logger = Rails.logger`, or whatever logger you're using in your app.



### Trap your own signals

If you want LoopHard to trap signals itself, you'll need to call `LoopHard::SignalTrap.trap_signals`

By default it'll trap INT, TERM and USR1, but you can pass the signals you'd like trapped
as a parameter to `trap_signals`.

Only do this if you are sure nothing else in your app is trapping signals, because there can only be one signal handler
per process. For example, if you are using Siekiq, **do not do this**, or you will get in the way of the Sidekiq shutdown
process.

If you are already trapping signals yourself, you can call `LoopHard::SignalTrap.signal_trapped` when you trap a signal
that should stop your loops.


## Version Compatibility and Continuous Integration

Tested with [Travis](https://travis-ci.org/dmagliola/loop_hard) using Ruby 2.1.1, 2.1.5 and 2.2.2.

LoopHard does work with Ruby 1.9, however, Sidekiq doesn't, so the Sidekiq trap won't work, but the rest will.

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
