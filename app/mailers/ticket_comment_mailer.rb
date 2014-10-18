class TicketCommentMailer < ActionMailer::Base
  default from: "from@example.com"

  def customer_ticket_reply(ticket)
    mail to: ticket.customer_email, subject: 'Your ticket received new reply'
  end

  def staff_ticket_reply(ticket)
    mail to: ticket.staff_email, subject: 'Your ticket received new reply'
  end

  module CommentCallbacks
    extend ActiveSupport::Concern

    included do
      after_create :notify_people, if: 'target.is_a?(Ticket)'
    end

    def notify_people
      TicketCommentMailer.customer_ticket_reply(target)
      TicketCommentMailer.staff_ticket_reply(target)
    end
  end
end
