class TasksController < ApplicationController
  before_action :authenticate_user!
  include CableReady::Broadcaster
  include ApplicationHelper
  def index
    p hide_task_closed
    @tasks = hide_task_closed ? current_user.tasks.not_closed : current_user.tasks
    p @tasks.size
  end

  def done
    p params
  end

  def start

  end

  def destroy

  end

  def hide_closed_task
    p params
  end
end
