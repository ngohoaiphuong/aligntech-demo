class TasksController < ApplicationController
  before_action :authenticate_user!
  include CableReady::Broadcaster
  include ApplicationHelper
  def index
    @tasks = hide_task_closed ? current_user.tasks.not_closed : current_user.tasks
  end
end
