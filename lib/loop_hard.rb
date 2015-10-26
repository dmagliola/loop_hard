require 'logger'
require 'loop_hard/logger'
require 'loop_hard/loop'
require 'loop_hard/sidekiq_trap'
require 'loop_hard/signal_trap'
require 'loop_hard/timeout_trap'
require 'loop_hard/version'

# Have loops with a timeout, that listen to signals to know if they should stop prematurely
module LoopHard
end