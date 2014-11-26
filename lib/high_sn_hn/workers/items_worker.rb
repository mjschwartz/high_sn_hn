module HighSnHn

  class ItemsWorker
    @queue = :items_queue

    def self.perform(min_item, max_item)
      return unless min_item.to_i > 0 && max_item.to_i > 0
      (min_item..max_item).each do |id|
        begin
          klass = false
          item = HighSnHn::HnItem.new(id)

          if item.complete?
            return true
          else
            #LOGGER.info("Fetching HnItem ##{id}")
            item.fetch
          end

        rescue NullItemResult => e
          # there was no HTTP result - requeue
          LOGGER.error("#{e}")
          redis = Redis.new
          count = redis.hmget 'failed_get', id
          if count && count.length
            count = count.first.to_i
            if count < 5
              redis.hmset 'failed_get', id, count + 1
              Resque.enqueue(HighSnHn::ItemsWorker, id, id)
            end
          else
            redis.hmset 'failed_get', id, 1
            Resque.enqueue(HighSnHn::ItemsWorker, id, id)
          end
        end
      end
    rescue Exception => e
      LOGGER.error("there was some other error: #{e}")
      LOGGER.error("#{e.backtrace.join("\n")}")
    end
  end
end