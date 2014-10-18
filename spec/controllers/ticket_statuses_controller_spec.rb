require 'rails_helper'

RSpec.describe TicketStatusesController, :type => :controller do
  let :resource_name do
    'ticket_statuses'
  end

  let :resource_params do
    {
      name: 'thestatus',
    }
  end

  it_behaves_like 'json resource'
end
