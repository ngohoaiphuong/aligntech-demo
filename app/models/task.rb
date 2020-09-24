class Task < ApplicationRecord
  include CableReady::Broadcaster
  include ApplicationHelper
  belongs_to :user
  default_scope { order(created_at: :desc) }

  enum status: [ :openning, :process, :closed ]
  enum priority: [ :important, :urgent, :both ]
end
