module HighSnHn

  class TopStoryWorker
    @queue = :high_sn

    def self.perform
      #LOGGER.info("Fetching top stories")
      top = HighSnHn::HnTopStories.new

      unless top.stories.blank?
        top.stories.map do |id|
          begin
            HighSnHn::HnItem.new(id).fetch
          rescue NullItemResult => e
            # there was no HTTP result for the item fetch - requeue
            LOGGER.error("#{e}")
            HighSnHn::ReEnqueueItem.new(id)
          end
        end
      end
    rescue Exception => e
      LOGGER.error("there was some other error: #{e}")
      LOGGER.error("#{e.backtrace.join("\n")}")
    end
  end
end