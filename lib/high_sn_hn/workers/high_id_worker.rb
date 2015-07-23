module HighSnHn

  class EmptyHighId < RuntimeError; end

  class HighIdWorker
    @queue = :high_sn

    def self.perform
      #LOGGER.info("Fetching current high id")
      previous = false
      high_id = HighSnHn::HnHighId.new.id
      raise EmptyHighId, 'The API did not return a High ID' if high_id.blank?
      #LOGGER.info("High id now #{high_id}")

      REDIS.multi do
        previous = REDIS.get('highest_id')
        REDIS.set('highest_id', high_id + 1)
      end

      Resque.enqueue(HighSnHn::ItemsWorker, previous.value.to_i, high_id) if previous

    rescue EmptyHighId
      LOGGER.error('The API did not return a High ID')

    rescue Exception => e
      LOGGER.error("there was some other error: #{e}")
      LOGGER.error("#{e.backtrace.join("\n")}")
    end
  end
end