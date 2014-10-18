class TicketStatus < ActiveRecord::Base
  validate :name, uniqueness: true
  scope :default, -> { where default: true }
  after_save do
    if default
      TicketStatus
        .all
        .where
        .not(id: id)
        .update_all(default: false)
    end
  end
end
