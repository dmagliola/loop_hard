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
    start = Time.now

    LoopHard.loop(timeout: 0.1) do
      # do nothing
    end

    time_elapsed = Time.now - start

    assert_in_delta 0.1, time_elapsed, 0.02
  end
end
