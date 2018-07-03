# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require "socket" # for Socket.gethostname
require "koala"

# Generate a repeating message.
#
# This plugin is intented only as an example.

class LogStash::Inputs::Facebook < LogStash::Inputs::Base

  config_name "facebook"

  # If undefined, Logstash will complain, even if codec is unused.
  default :codec, "plain"

  # OAuth token to access the facebook API with
  config :oauth_token, :validate => :string, :required =>true

  # Set the frecuency.
  config :interval, :validate => :number, :required =>true

  # Facebook ID of the feed to monitor
  config :facebook_id, :validate => :number, :required =>true

  # Fields of the feed 
  config :fields , :validate => :array , :required =>true

  public
  def register
    @api = Koala::Facebook::API.new(@oauth_token)
  end # def register

  def run(queue)
    # we can abort the loop if stop? becomes true
    while !stop?
      feed = @api.get_connections(@facebook_id, "feed" , { limit: 10, fields: @fields })
      feed.each do |p|
        event = LogStash::Event.new(p)
        decorate(event)
        queue << event
      end

      # because the sleep interval can be big, when shutdown happens
      # we want to be able to abort the sleep
      # Stud.stoppable_sleep will frequently evaluate the given block
      # and abort the sleep(@interval) if the return value is true
      Stud.stoppable_sleep(@interval) { stop? }
    end # loop
  end # def run

  def stop
    # nothing to do in this case so it is not necessary to define stop
    # examples of common "stop" tasks:
    #  * close sockets (unblocking blocking reads/accepts)
    #  * cleanup temporary files
    #  * terminate spawned threads
  end
end # class LogStash::Inputs::Facebook
