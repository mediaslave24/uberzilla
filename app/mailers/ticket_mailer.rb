class TicketMailer < ActionMailer::Base
  default from: "from@example.com"

  def change_status(ticket, from, to)
  end
end
