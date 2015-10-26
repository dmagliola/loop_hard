module LoopHard
  module TimeoutTrap
    class << self
      def continue?(options)
        if options[:maximum_end_time] && Time.now > options[:maximum_end_time]
          LoopHard.logger.info "Ending loop due to timeout"
          return false
        end
        return true
      end
    end
  end
end
