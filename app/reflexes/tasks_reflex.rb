# frozen_string_literal: true

class TasksReflex < ApplicationReflex
  delegate :current_user, to: :connection
  include CableReady::Broadcaster
  def done
    task = Task.find(element.dataset[:id])
    # p task
    p element.dataset[:c]
    p dom_id(task)
    p "#task_#{task.id}"
    channel = element.dataset[:c]
    cable_ready[channel].inner_html(
      selector: "#task-name",
      position: 'afterbegin',
      html: '<h1>Ngô Hoài Phương</h1>'
    )
    cable_ready.broadcast channel, true
  end

  def start
    task = Task.find(element.dataset[:id])
    task.process!
    p '------------------start change  status--------------------'
    p task
    p '----------------------------------------------------------'
  end
end
