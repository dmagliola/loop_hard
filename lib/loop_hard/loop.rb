module LoopHard
  class << self
    # Loop until the passed in block breaks, or until one of the traps open.
    # Will yield to the block passed in until it decides to stop looping.
    # Your block should break once it's done.
    # @param options
    #   - timeout [Int] Maximum time to run (eg: "10" for 10 seconds, 10.minutes if you are using Rails). Defaults to infinite
    #   - traps [Array of Classes] Which traps to run. Defaults to [SidekiqTrap, SignalTrap, TimeoutTrap] (all of them)
    def loop(options = {})
      default_options = { timeout: nil,
                          traps: [SidekiqTrap, SignalTrap, TimeoutTrap] }
      options = default_options.merge(options)

      options[:maximum_end_time] = (options[:timeout] ? Time.now + options[:timeout] : nil)

      while continue_looping?(options)
        yield # Block will call "break" once it's out of rows, which will break this loop
      end
    end

    private

    # Decide whether to continue looping, based on the traps involved.
    def continue_looping?(options)
      options[:traps].all?{|trap| trap.continue?(options)}
    end
  end
end
