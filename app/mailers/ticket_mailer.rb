class TicketMailer < ActionMailer::Base
  default from: "from@example.com"

  def customer_ticket_created(ticket)
    @ticket = ticket
    mail to: @ticket.customer_email, subject: 'Ticket Created'
  end

  def department_ticket_created(ticket)
    @ticket = ticket
    @staffs = @ticket.department.try(:staffs) || []
    mail to: @staffs.map(&:email), subject: 'Ticket Created'
  end

  def customer_ticket_updated(ticket)
    @ticket = ticket
    mail to: @ticket.customer_email, subject: 'Ticket Updated'
  end

  def staff_ticket_updated(ticket)
    @ticket = ticket
    mail to: @ticket.staff_email, subject: 'Ticket Updated'
  end

  module TicketCallbacks
    extend ActiveSupport::Concern

    included do
      after_create :notify_about_creation
      after_update :notify_about_update
    end

    def notify_about_creation
      TicketMailer.customer_ticket_created(self)
      TicketMailer.department_ticket_created(self)
    end

    def notify_about_update
      TicketMailer.customer_ticket_updated(self)
      TicketMailer.staff_ticket_updated(self)
    end
  end
end
