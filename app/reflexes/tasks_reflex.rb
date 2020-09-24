# frozen_string_literal: true

class TasksReflex < ApplicationReflex
  delegate :current_user, to: :connection
  delegate :render, to: ApplicationController

  before_reflex :reload

  def show_hide_task
    cable_ready[task_channel].set_cookie(
      cookie: "hide_closed_task=#{!element.checked}"
    )
    add_cable(
      '#show-hide-tasks',
      render(partial: 'tasks/task_option', locals: { checked: element.checked })
    )
    add_cable(
      "#tasks",
      render(partial: 'tasks/tasks', locals: { tasks: tasks(element.checked) })      
    )
    cable_ready.broadcast
  end

  def done(id)
    task = current_user.tasks.find(id)
    task.closed!
    add_cable(
      "#task-#{id}",
      render(
        partial: 'tasks/task', locals: { task: task.reload }
      )      
    )
    notice(I18n.t('tasks.alert.done', { task: task.description }), 'alert-success')
    cable_ready.broadcast    
  end

  def start(id)
    task = current_user.tasks.find(id)
    task.process!
    add_cable(
      "#task-#{id}",
      render(
        partial: 'tasks/task', locals: { task: task.reload }
      )
    )
    notice(I18n.t('tasks.alert.start', { task: task.description }), 'alert-success')
    cable_ready.broadcast    
  end

  def remove(id, hide_task_closed)
    task = current_user.tasks.find(id)
    task_description = task.description
    task.destroy
    reload
    add_cable(
      "#tasks",
      render(
        partial: 'tasks/tasks', locals: { 
          tasks: !hide_task_closed ? current_user.tasks.not_closed : current_user.tasks 
        }
      )
    )
    notice(I18n.t('tasks.alert.delete', { task: task_description }), 'alert-success')
    cable_ready.broadcast    
  end

  def add(description, important, urgent, hide_task_closed)
    task = current_user.tasks.new(
      description: description, 
      status: :openning,
      priority: priority(important, urgent)
    )
    show_error(task) and return if !task.valid?
    task.save
    reload
    notice(I18n.t('tasks.alert.add', { task: task.description }), 'alert-success')
    show_new_item(hide_task_closed)
  end

  private
  def notice(message, mode)
    cable_ready[task_channel].insert_adjacent_html(
      selector: '#alert-message',
      position: 'afterbegin',
      html: render(
        partial: 'layouts/alert/message', locals: { 
          message: message.html_safe, 
          mode: mode
        }
      )
    )
  end

  def show_new_item(hide_task_closed)
    add_cable(
      "#tasks",
      render(
        partial: 'tasks/tasks', locals: { 
          tasks: !hide_task_closed ? current_user.tasks.not_closed : current_user.tasks 
        }
      )
    )

    add_cable(
      "#new-task",
      render(
        partial: 'tasks/new_task'
      )
    )

    add_cable(
      '#error-description',
      render(
        partial: 'shared/error', locals: { 
        description: nil
        }
      )
    )
    cable_ready.broadcast
  end
  
  def show_error(task)
    add_cable(
      '#error-description',
      render(
        partial: 'shared/error', locals: { 
        description: messages(task.errors.messages.flatten).html_safe 
        }
      )
    )
    cable_ready.broadcast    
  end

  def add_cable(selector, html)
    cable_ready[task_channel].inner_html(
      selector: selector,
      position: 'afterbegin',
      html: html
    )
  end

  def messages(errors)
    errors_ = []
    Hash[*errors].each{|k,v| errors_.push("#{k.to_s.titlecase}: #{v.join(',')}")}
    errors_.join('</br>')
  end

  def priority(important, urgent)
    return :both if important && urgent
    return :important if important 
    return :urgent if urgent 
    nil
  end

  def tasks(except_clodes_task)
    !except_clodes_task ? current_user.tasks.not_closed : current_user.tasks
  end

  def task_channel
    "task-#{current_user.id}"    
  end

  def reload
    current_user.reload
  end
end
