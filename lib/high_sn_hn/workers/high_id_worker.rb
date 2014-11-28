module HighSnHn

  class HighIdWorker
    @queue = :id_queue

    def self.perform
      LOGGER.info("Fetching current high id")
      high_id = HighSnHn::HnHighId.new.id
      previous = false
      #LOGGER.info("High id now #{high_id}")

      REDIS.multi do
        previous = REDIS.get('highest_id')
        REDIS.set('highest_id', high_id + 1)
      end

      Resque.enqueue(HighSnHn::ItemsWorker, previous.value.to_i, high_id) if previous

    rescue Exception => e
      LOGGER.error("there was some other error: #{e}")
      LOGGER.error("#{e.backtrace.join("\n")}")
    end
  end
end