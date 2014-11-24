module HighSnHn

  class TopStoryWorker
    @queue = :top_queue

    def self.perform
      LOGGER.info("Fetching top stories")
      top = HighSnHn::HnTopStories.new

      unless top.stories.blank?
        top.stories.map {|id| HighSnHn::HnItem.new(id).fetch }
      end

    rescue Exception => e
      LOGGER.error("there was some other error: #{e}")
      LOGGER.error("#{e.backtrace.join("\n")}")
    end
  end
end