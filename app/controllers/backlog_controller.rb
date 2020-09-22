class BacklogController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tasks = current_user.tasks
  end
end
