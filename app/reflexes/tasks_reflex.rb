# frozen_string_literal: true

class TasksReflex < ApplicationReflex
  delegate :current_user, to: :connection
  delegate :render, to: ApplicationController

  def show_hide_task
    cable_ready[task_channel].set_cookie(
      cookie: "hide_closed_task=#{!element.checked}"
    )

    cable_ready[task_channel].inner_html(
      selector: '#show-hide-tasks',
      position: 'afterbegin',
      html: render(partial: 'tasks/task_option', locals: { checked: element.checked })
    )

    cable_ready[task_channel].inner_html(
      selector: '#tasks',
      position: 'afterbegin',
      html: render(partial: 'tasks/tasks', locals: { tasks: tasks(element.checked) })
    )

    cable_ready.broadcast
  end

  def done(id)
    task = current_user.tasks.find(id)
    task.closed!
    cable_ready[task_channel].inner_html(
      selector: "#task-#{id}",
      position: 'afterbegin',
      html: render(
        partial: 'tasks/task', locals: { task: task.reload }
      )
    )
    cable_ready.broadcast    
  end

  def start(id)
    task = current_user.tasks.find(id)
    task.process!
    cable_ready[task_channel].inner_html(
      selector: "#task-#{id}",
      position: 'afterbegin',
      html: render(
        partial: 'tasks/task', locals: { task: task.reload }
      )
    )
    cable_ready.broadcast    
  end

  def remove(id, hide_task_closed)
    task = current_user.tasks.find(id)
    task.destroy
    cable_ready[task_channel].inner_html(
      selector: "#tasks",
      position: 'afterbegin',
      html: render(
        partial: 'tasks/tasks', locals: { 
          tasks: !hide_task_closed ? current_user.tasks.not_closed : current_user.tasks 
        }
      )
    )
    cable_ready.broadcast    
  end

  private
  def tasks(except_clodes_task)
    !except_clodes_task ? current_user.tasks.not_closed : current_user.tasks
  end

  def task_channel
    "task-#{current_user.id}"    
  end
end
