module LoopHard
  class << self
    attr_writer :logger

    # Set the Logger for LoopHard
    def logger
      @logger ||= Logger.new($stdout)
    end
  end
end