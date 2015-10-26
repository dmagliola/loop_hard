require_relative "test_helper"

class LoopTest < MiniTest::Test
  should "loop until break if nothing stops it" do
    i = 0
    LoopHard.loop do
      i += 1
      break if i == 10
    end

    assert_equal 10, i
  end

  should "loop for 100ms" do
    i = 0
    LoopHard.loop(timeout: 0.1) do
      sleep 0.01
      i += 1
    end

    # Not an exact science, this thing...
    assert_operator i, :>, 7
    assert_operator i, :<, 12
  end
end
