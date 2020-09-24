class TaskChannel < ApplicationCable::Channel
  def subscribed
    @user_id = params[:user_id]
    stream_from "task-#{current_user&.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
