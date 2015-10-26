require_relative "test_helper"

class SignalTrapTest < MiniTest::Test
  should "continue if no signals have been trapped" do
    assert LoopHard::SignalTrap.continue?
  end

  should "stop if a signal has been trapped" do
    LoopHard::SignalTrap.signal_trapped("TERM")
    assert_equal false, LoopHard::SignalTrap.continue?
    LoopHard::SignalTrap.reset_signal_trapped
  end

  should "reset signal trap on demand" do
    LoopHard::SignalTrap.signal_trapped("TERM")
    assert_equal false, LoopHard::SignalTrap.continue?
    LoopHard::SignalTrap.reset_signal_trapped
    assert_equal true, LoopHard::SignalTrap.continue?
  end

  should "trap signals" do
    LoopHard::SignalTrap.trap_signals
    assert_nil LoopHard::SignalTrap.instance_variable_get(:@signal_trapped)
    Process.kill "TERM", Process.pid
    assert_equal "TERM", LoopHard::SignalTrap.instance_variable_get(:@signal_trapped)
    LoopHard::SignalTrap.reset_signal_trapped
  end
end
