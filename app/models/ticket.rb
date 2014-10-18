class Ticket < ActiveRecord::Base
  belongs_to :customer
  belongs_to :department
  belongs_to :status, class_name: 'TicketStatus'
  belongs_to :staff
  include GenerateUid
  before_create 'self.uid = generate_uid'
end
