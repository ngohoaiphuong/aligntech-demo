class Task < ApplicationRecord
  include CableReady::Broadcaster
  include ApplicationHelper
  belongs_to :user
  default_scope { order(created_at: :desc) }

  enum status: [ :openning, :process, :closed ]
  enum priority: [ :important, :urgent, :both ]

  validate do |task|
    task.errors.add(:description, I18n.t('errors.description.blank')) if task.description.blank? || task.description.nil?
    task.errors.add(:description, I18n.t('errors.description.max_length', { count: 40 })) if task.description.present? && task.description.length > 40
  end  
end
