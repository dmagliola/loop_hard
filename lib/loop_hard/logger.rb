module LoopHard
  class << self
    attr_writer :logger

    def logger
      @logger ||= Logger.new($stdout)
    end
  end
end