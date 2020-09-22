module ErrorMessageHelper
  include CableReady::Broadcaster
  def show_error_message(element, message, remove_diable_element=nil)
    channel = "system_listen_#{cookies['channelID']}"
    cable_ready[channel].inner_html(
      selector: element,
      position: 'afterbegin',
      html: render_to_string(partial: 'shared/error', locals: { description: message.html_safe })
    )
    if remove_diable_element.present?
      cable_ready[channel].remove_attribute(
        selector: remove_diable_element,
        name: 'disabled'
      )
    end
    cable_ready.broadcast
  end
end