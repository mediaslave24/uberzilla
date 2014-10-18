require 'rails_helper'

RSpec.describe Ticket, :type => :model do
  ALPHA_PAT = %/\\w{3}/
  HEX_PAT = %/[0-9a-f]{2}/
  PATTERN = /\A#{ALPHA_PAT}-#{HEX_PAT}-#{ALPHA_PAT}-#{HEX_PAT}-#{ALPHA_PAT}\z/

  it 'generates correct uid after creation' do
    tickets = create_list :ticket, 5
    expect(tickets.map(&:uid)).to satisfy do |uids|
      uids.all? do |uid|
        uid =~ PATTERN
      end
    end
  end

  context '#to_param' do
    let(:ticket) { create :ticket }

    it 'is taken from "uid"' do
      expect(ticket.to_param).to eq(ticket.uid)
    end
  end

  context '#changelog', paper_trail: true do
    let! :ticket do
      create :ticket
    end

    it 'returns expected info' do
      ticket.update! subject: 'Why client needs changelog?'
      ticket.update! subject: 'Why?'
      expect(ticket.changelog.length).to eq(3)
    end
  end

  context '#status' do
    let! :default_status do
      create :ticket_status, default: true
    end

    let! :other_statuses do
      create_pair :ticket_status
    end

    let! :ticket do
      create :ticket
    end

    it 'is equal to first TicketStatus in the database which is default' do
      expect(ticket.status).to eq(default_status)
    end
  end

  it 'triggers TicketMailer#customer_ticket_created on creation' do
    expect(TicketMailer).to receive(:customer_ticket_created).with(kind_of(Ticket))
    create :ticket
  end

  it 'triggers TicketMailer#customer_ticket_created on creation' do
    expect(TicketMailer).to receive(:department_ticket_created).with(kind_of(Ticket))
    create :ticket
  end

  it 'triggers TicketMailer#customer_ticket_updated and Ticket#customer on update' do
    expect(TicketMailer).to receive(:customer_ticket_updated).with(kind_of(Ticket))
    create(:ticket).update subject: '123'
  end

  it 'triggers TicketMailer#staff_ticket_updated and Ticket#customer on update' do
    expect(TicketMailer).to receive(:staff_ticket_updated).with(kind_of(Ticket))
    create(:ticket).update subject: '123'
  end
end
