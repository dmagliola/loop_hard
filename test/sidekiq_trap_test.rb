require_relative "test_helper"

class SidekiqTrapTest < MiniTest::Test
  should "continue if Sidekiq isn't there" do
    assert LoopHard::SidekiqTrap.continue?
  end

  # This test is EXTREMELY important, because we're basically using undocumented shit in Sidekiq, so it needs to
  #   do this in the most abstracted way possible
  # Unfortunately, I can't really do that, because to get Sidekiq to the point of listening to signals, I need to
  #   start too much crap, so I just need to hope that if this changes, the internals will change enough that this will
  #   raise somehow
  should "sidekiq kill" do
    require 'sidekiq'
    require 'sidekiq/cli'
    require 'celluloid/current'
    require 'sidekiq/launcher'

    assert LoopHard::SidekiqTrap.continue?
    assert_equal true, !!Sidekiq.server?
    assert_equal true, !!defined?(Sidekiq::Fetcher)
    assert_equal false, !!Sidekiq::Fetcher.done?

    Sidekiq::Fetcher.done! # This is one of the many things that end up happening when Sidekiq gets a USR1 or TERM signal

    assert_equal false, LoopHard::SidekiqTrap.continue?

    Sidekiq::Fetcher.reset # Reset it so the rest of Sidekiq still works
  end
end
