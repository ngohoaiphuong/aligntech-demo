module AlertHelper
  include CableReady::Broadcaster
  def error(element, message)
    cable_ready["system_listen_#{cookies['channelID']}"].insert_adjacent_html(
      selector: element,
      position: 'afterbegin',
      html: render_to_string(partial: 'layouts/alert/message', locals: { message: message, mode: 'alert-danger' })
    )
    cable_ready.broadcast
  end
end