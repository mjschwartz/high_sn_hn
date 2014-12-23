# require 'rest-firebase'
# require 'redis'
# require 'resque'

# module HighSnHn

#   class HighIdWatcher

#     attr_reader :streamer, :client
#     attr_accessor :reconnect

#     def initialize
#       @redis = Redis.new
#       @reconnect = true
#       @client = build_client()
#       @streamer = build_streamer()
#     end

#     def stream
#       @streamer.start
#     end

#     def stop
#       @reconnect = false
#       @streamer.close
#     end

#     def build_streamer
#       streamer = @client.event_source('maxitem/')

#       streamer.onopen      { |sock| onopen(sock) }
#       streamer.onmessage   { |event, data, sock| onmessage(event, data, sock) }
#       streamer.onerror     { |error| ononerror(error) }
#       streamer.onreconnect { |error, sock|  onreconnect(error, sock) }

#       streamer
#     end

#     def build_client
#       RestFirebase.new :site => 'https://hacker-news.firebaseio.com/v0/',
#         :secret => 'secret',
#         :auth => false
#     end

#     def onopen(sock)
#       puts "onopen message: #{sock}"
#     end

#     def ononerror(error)
#       if error.kind_of?(EOFError)
#         puts 'no worries - just EOF'
#       else
#         puts "uh-oh, a real error! #{error}"
#       end
#     end

#     def onmessage(event, data, sock)
#       if event == 'put' && data && data['data']
#         set_newest(data['data'])
#       end
#       puts "onmessage: #{data} (#{event})"
#     end

#     def onreconnect(error, sock)
#       p "reconnecting now, error was #{error} and @reconnect is #{@reconnect}"
#     end

#     def set_newest(id)
#       current = false

#       @redis.multi do
#         current = @redis.get('highest_id')
#         @redis.set('highest_id', id + 1)
#       end

#       Resque.enqueue(HighSnHn::ItemsWorker, current.value.to_i, id) if current
#     end

#   end
# end