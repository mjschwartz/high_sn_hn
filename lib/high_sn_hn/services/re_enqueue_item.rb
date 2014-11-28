module HighSnHn

  class ReEnqueueItem

    def initialize(id)
      @id = id
      # we don't want to keep requesting if we keep getting null
      if count < 5
        REDIS.hmset('failed_get', @id, count + 1)
        enqueue
      end
    end

    def count
      @_count ||= fetch_count
    end

    def fetch_count
      r = REDIS.hmget('failed_get', @id)
      r && r.length ? r.first.to_i : 0
    end

    def enqueue
      Resque.enqueue(HighSnHn::ItemsWorker, @id, @id)
    end
  end
end