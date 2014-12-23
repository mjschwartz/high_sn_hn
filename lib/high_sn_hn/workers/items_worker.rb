module HighSnHn

  class ItemsWorker
    @queue = :items_queue

    def self.perform(min_item, max_item)
      return unless min_item.to_i > 0 && max_item.to_i > 0
      (min_item..max_item).each do |id|
        begin
          #LOGGER.info("ItemsWorker for: #{id}")
          item = HighSnHn::HnItem.new(id)

          if item.should_fetch?
            #LOGGER.info("Fetching HnItem ##{id}")
            item.fetch
          end

        rescue NullItemResult => e
          # there was no HTTP result for the item fetch - requeue
          LOGGER.error("#{e}")
          HighSnHn::ReEnqueueItem.new(id)
        end
      end
    rescue Exception => e
      LOGGER.error("there was some other error: #{e}")
      LOGGER.error("#{e.backtrace.join("\n")}")
    end
  end
end