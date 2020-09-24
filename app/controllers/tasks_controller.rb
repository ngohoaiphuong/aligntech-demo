class TasksController < ApplicationController
  before_action :authenticate_user!
  include CableReady::Broadcaster
  include ApplicationHelper
  def index
    @tasks = hide_task_closed ? current_user.tasks.not_closed : current_user.tasks
  end

  def done
    task = current_user.tasks.find(params[:task_id])
    task.closed!
    redirect_to root_path
  end

  def start
    task = current_user.tasks.find(params[:task_id])
    task.process!
    redirect_to root_path
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to root_path
  end
end
