class SystemListenChannel < ApplicationCable::Channel
  def subscribed
    @channel_id   = params[:channel_id]
    @session_      = params[:session]
    @channel_name = "system_listen_#{@channel_id}"
    stream_from @channel_name
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
