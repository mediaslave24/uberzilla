require 'rails_helper'

RSpec.describe Comment, :type => :model do
  let! :ticket do
    create :ticket
  end

  it 'calls TicketCommentMailer#customer_ticket_reply on creation' do
    expect(TicketCommentMailer).to receive(:customer_ticket_reply).with(ticket)
    create :comment, target: ticket
  end

  it 'calls TicketCommentMailer#staff_ticket_reply on creation' do
    expect(TicketCommentMailer).to receive(:staff_ticket_reply).with(ticket)
    create :comment, target: ticket
  end
end
