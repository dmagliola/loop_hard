module LoopHard
  # If Sidekiq has decided to not process more jobs, then stop looping, to let this job end.
  #   This is a massive hack, and we totally shouldn't be doing this (as per mperham himself!)
  #     https://github.com/mperham/sidekiq/issues/2364
  #   But it's better than an ungraceful shutdown
  #   Also, we can't trap the signals ourselves, since Sidekiq is trapping them, and you can only have one "trap"
  module SidekiqTrap
    class << self

      # Returns false if Sidekiq has decided to stop taking new jobs. True otherwise.
      def continue?(options = nil)
        if defined?(Sidekiq) && Sidekiq.server? && defined?(Sidekiq::Fetcher) && Sidekiq::Fetcher.done?
          LoopHard.logger.info "Ending loop due to Sidekiq shutting down"
          return false
        end
        return true
      end
    end
  end
end
