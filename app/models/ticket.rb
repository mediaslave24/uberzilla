class Ticket < ActiveRecord::Base
  belongs_to :customer, class_name: 'Customer'
  belongs_to :staff, class_name: 'User'
  belongs_to :department
  belongs_to :status, class_name: 'TicketStatus'
  include GenerateUid
  before_create 'self.uid = generate_uid'
  alias_attribute :to_param, :uid
  validates_presence_of :subject, :body
  has_paper_trail

  def changelog
    versions.map(&:changeset)
  end
end
