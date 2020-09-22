class Task < ApplicationRecord
  belongs_to :user
  default_scope { order(updated_at: :desc) }
  enum status: [ :open, :process, :closed ]
  enum priority: [ :important, :urgent, :both ]
end
