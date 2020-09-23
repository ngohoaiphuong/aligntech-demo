module ApplicationHelper
  def channel_name
    "system_listen_#{cookies['channelID']}"
  end

  def session_name
    cookies[:uuid]
  end

  def system_listen_channel
    "system_listen-#{cookies[:uuid]}"
  end
end
