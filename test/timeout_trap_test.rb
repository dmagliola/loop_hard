require_relative "test_helper"

class TimeoutTrapTest < MiniTest::Test
  should "continue if no options are passed in" do
    assert LoopHard::TimeoutTrap.continue?({})
  end

  should "continue if the maximum end time is in the future" do
    assert LoopHard::TimeoutTrap.continue?(maximum_end_time: Time.now + 2)
  end

  should "stop if the maximum end time is in the past" do
    assert_equal false, LoopHard::TimeoutTrap.continue?(maximum_end_time: Time.now - 2)
  end
end
