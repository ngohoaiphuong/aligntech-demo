class Task < ApplicationRecord
  include CableReady::Broadcaster
  include ApplicationHelper
  belongs_to :user
  default_scope { order(created_at: :desc) }

  enum status: [ :openning, :process, :closed ]
  enum priority: [ :important, :urgent, :both ]

  after_commit :refresh, on: [:update]

  private
  def refresh
    cable_ready["task-#{self.user_id}"].text_content(
      selector: "#demo",
      text: '<h1>Ngô Hoài Phương</h1>'
    )
    cable_ready.broadcast
  end
end
