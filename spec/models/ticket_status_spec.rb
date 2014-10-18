require 'rails_helper'

RSpec.describe TicketStatus, :type => :model do
  it 'changes "default" on all tickets when in other it became true' do
    ticket1, ticket2 = create_pair :ticket_status, default: false
    ticket1.update! default: true

    expect {
      ticket2.update! default: true
    }.to change {
      ticket1.reload.default
    }.from(true).to(false)
  end
end
