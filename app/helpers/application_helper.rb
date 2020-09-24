module ApplicationHelper
  def system_listen_channel
    "system_listen-#{cookies[:uuid]}"
  end

  def task_channel
    "task-#{current_user.id}"
  end

  def hide_task_closed
    [true, 'true'].include? cookies[:hide_closed_task]
  end
end
