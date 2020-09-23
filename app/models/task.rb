class Task < ApplicationRecord
  include CableReady::Broadcaster
  include ApplicationHelper

  belongs_to :user
  default_scope { order(updated_at: :desc) }
  enum status: [ :openning, :process, :closed ]
  enum priority: [ :important, :urgent, :both ]

  after_commit :refresh, on: [:update]
  attr_accessor :uuid

  def process!
    self.update(status: :process)
  end

  def closed!
    self.update(status: :closed)
  end
  
  def action!(session)
    p session
    cable_ready[session].inner_html(
      selector: "#task-item-#{self.id}",
      position: 'afterbegin',
      html: '<h1>Ngô Hoài Phương</h1>'
    )
    cable_ready.broadcast
  end

  private
  def refresh
    cable_ready["system_listen_#{self.uuid}"].morph(
      selector: '#' + ActionView::RecordIdentifier.dom_id(self),
      html: ApplicationController.render(self)
    )
    cable_ready.broadcast "system_listen_#{self.uuid}", true
  end
end
