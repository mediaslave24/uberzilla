require 'rails_helper'

RSpec.describe TicketsController, :type => :controller do
  let(:ticket_params) do
    {
      'subject' => 'Why to use angularjs in project?',
      'body' => 'Because easier to compose views'
    }
  end

  let(:customer_params) do
    {
      'name' => 'The Name',
      'email' => 'email@example.org'
    }
  end

  context 'POST create' do
    it 'responds with 200 and ticket json on success' do
      post :create,
        ticket: ticket_params,
        customer: customer_params,
        format: :json

      expect(response).to be_successful
      expect(assigns(:ticket)).to be_persisted
      expect(assigns(:ticket).attributes).to include(ticket_params)
      expect(assigns(:ticket).customer.attributes).to include(customer_params)
    end

    it 'responds with 422 on failure' do
      post :create,
        ticket: ticket_params.merge(body: nil),
        customer: customer_params,
        format: :json
      expect(response.status).to eq(422)
    end
  end

  context 'PUT update' do
    let!(:customer) { create :customer, customer_params }
    let!(:ticket) { create :ticket, customer: customer }

    it 'responds with 200 and ticket json on success' do
      put :update,
        ticket: ticket_params,
        id: ticket.to_param,
        customer: customer_params,
        format: :json
      expect(assigns(:ticket).attributes).to include(ticket_params)
    end

    it 'responds with 422 on failure' do
      put :update,
        ticket: ticket_params,
        id: ticket.to_param,
        customer: customer_params,
        format: :json
      expect(assigns(:ticket).attributes).to include(ticket_params)
    end
  end

  context 'GET changelog' do
    let! :customer do
      create :customer, customer_params
    end

    let! :ticket do
      create(:ticket, customer: customer).tap { |t| t.update subject: 'Random Name' }
    end

    it 'returns ticket changelog' do
      get :changelog,
        format: :json,
        id: ticket.to_param,
        customer: customer_params
      expect(json).to eq(ticket.changelog.as_json)
    end
  end
end
