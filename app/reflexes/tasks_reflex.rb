# frozen_string_literal: true

class TasksReflex < ApplicationReflex
  delegate :current_user, to: :connection
  delegate :render, to: ApplicationController

  def show_hide_task
    channel = "task-#{current_user.id}"

    cable_ready[channel].set_cookie(
      cookie: "hide_closed_task=#{!element.checked}"
    )

    cable_ready[channel].inner_html(
      selector: '#show-hide-tasks',
      position: 'afterbegin',
      html: render(partial: 'tasks/task_option', locals: { checked: element.checked })
    )

    cable_ready[channel].inner_html(
      selector: '#tasks',
      position: 'afterbegin',
      html: render(partial: 'tasks/tasks', locals: { tasks: tasks(element.checked) })
    )

    cable_ready.broadcast
  end

  def done_task
    task = current_user.tasks.where(id: element.dataset[:id]).first
    p task
    if task
      task.closed!
    end
    # p current_user
    # cable_ready["task-#{current_user.id}"].inner_html(
    #     selector: "#task-action-#{task.id}",
    #     position: 'afterbegin',
    #     html: '<h1>Ngô Hoài Phương</h1>'
    #   )
    # cable_ready["task-#{current_user.id}"].text_content(
    #     # selector: "#task-action-#{task.id}",
    #     selector: "#demo",
    #     text: '<h1>Ngô Hoài Phương</h1>'
    #   )
    # cable_ready.broadcast current_user, true
    # p task
    # p element.dataset[:c]
    # p dom_id(task)
    # p "#task_#{task.id}"
    # channel = element.dataset[:c]
    # cable_ready[channel].inner_html(
    #   selector: "#task-name",
    #   position: 'afterbegin',
    #   html: '<h1>Ngô Hoài Phương</h1>'
    # )
    # cable_ready.broadcast channel, true
  end

  def start_task
    task = Task.find(element.dataset[:id])
    task.process!
    p '------------------start change  status--------------------'
    p task
    p '----------------------------------------------------------'
  end

  private
  def tasks(except_clodes_task)
    !except_clodes_task ? current_user.tasks.not_closed : current_user.tasks
  end
end
