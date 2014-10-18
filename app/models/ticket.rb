class Ticket < ActiveRecord::Base
  belongs_to :customer
  belongs_to :department
  belongs_to :status
  belongs_to :staff
end
