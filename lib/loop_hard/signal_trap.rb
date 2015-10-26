module LoopHard
  module SignalTrap
    class << self
      @signal_trapped = nil

      def continue?(options = nil)
        if !@signal_trapped.nil?
          LoopHard.logger.info "Ending loop due to #{@signal_trapped} signal"
          return false
        end
        return true
      end

      def trap_signals(signals = ["INT", "TERM", "USR1"])
        signals.each do |sig|
          Signal.trap sig do
            signal_trapped(sig)
          end
        end
      end

      def signal_trapped(sig)
        @signal_trapped = sig
      end

      def reset_signal_trapped
        @signal_trapped = nil
      end
    end
  end
end
