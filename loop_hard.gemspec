lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "loop_hard/version"

Gem::Specification.new do |s|
  s.name        = 'loop_hard'
  s.version     = LoopHard::VERSION
  s.summary     = "Have long-running loops with a timeout, that listen to signals to know if they should stop prematurely"
  s.description = %q{LoopHard allows you to have long-running worker loops that will stop after a while,
                     and also stop if they get an external signal to stop (for example, if Sidekiq stops due to a USR1,
                     or a KILL signal is trapped.
                   }
  s.authors     = ["Daniel Magliola"]
  s.email       = 'dmagliola@crystalgears.com'
  s.homepage    = 'https://github.com/dmagliola/loop_hard'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|s.features)/})
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 1.9.3"

  s.add_runtime_dependency "logger"

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"

  s.add_development_dependency "minitest"
  s.add_development_dependency "minitest-reporters"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "mocha"
  s.add_development_dependency "simplecov"

  s.add_development_dependency "sidekiq"

  s.add_development_dependency "coveralls"
  s.add_development_dependency "codeclimate-test-reporter"
end
