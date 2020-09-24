class SystemListenChannel < ApplicationCable::Channel
  def subscribed
    # @channel_id   = params[:channel_id]
    # @session      = params[:session]
    # @channel_name = (current_user.is_a? String) ? "system_listen_#{current_user}" : "system_listen_#{current_user&.id}"
    stream_from "system_listen-#{current_uuid}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
