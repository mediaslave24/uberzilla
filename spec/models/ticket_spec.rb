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
end
