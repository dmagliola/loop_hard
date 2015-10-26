module LoopHard
  module SignalTrap
    class << self
      @signal_trapped = nil

      # Returns false if a signal has been trapped. True otherwise.
      def continue?(options = nil)
        if !@signal_trapped.nil?
          LoopHard.logger.info "Ending loop due to #{@signal_trapped} signal"
          return false
        end
        return true
      end

      # Set up a signal trap for the signals specified (defaults to INT, TERM and USR1)
      # Do not call this if you're using Sidekiq or any other library that handles their own signals!
      def trap_signals(signals = ["INT", "TERM", "USR1"])
        signals.each do |sig|
          Signal.trap sig do
            signal_trapped(sig)
          end
        end
      end

      # Set the "signal" flag, if you've trapped a signal yourself, so that loops stop looping.
      def signal_trapped(sig)
        @signal_trapped = sig
      end

      # Reset the "signal" flag, so that loops keep looping.
      def reset_signal_trapped
        @signal_trapped = nil
      end
    end
  end
end
