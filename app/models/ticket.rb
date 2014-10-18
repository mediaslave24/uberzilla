class Ticket < ActiveRecord::Base
  belongs_to :customer, polymorphic: true
  belongs_to :staff, polymorphic: true
  belongs_to :department
  belongs_to :status, class_name: 'TicketStatus'
  include GenerateUid
  before_create 'self.uid = generate_uid'
  before_create 'self.status = TicketStatus.default.first'
  alias_attribute :to_param, :uid
  validates_presence_of :subject, :body
  has_paper_trail

  with_options allow_nil: true, prefix: true do |opt|
    opt.delegate :name, :email, to: :customer
    opt.delegate :name, to: :department
    opt.delegate :name, :id, to: :status
    opt.delegate :name, :email, :id, to: :staff
  end

  def changelog
    versions.map(&:changeset)
  end

  def as_json(*)
    super.merge(
      customer_email: customer_email,
      customer_name: customer_name,
      department_name: department_name,
      status_name: status_name,
      staff_name: staff_name,
      staff_email: staff_email,
      status_id: status_id,
      staff_id: staff_id
    )
  end

  include Pusher::TicketCallbacks
  include TicketMailer::TicketCallbacks
end
