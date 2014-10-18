require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  def login(login, password)
    post :create,
      login: staff.email,
      password: password,
      format: :json
  end

  def logout
    delete :destroy, format: :json
  end

  let(:password) { 'password' }

  context 'unauthenticated' do
    let :errors do
      {
        'error1' => 'abc'
      }
    end
    it 'returns failure with errors' do
      get :unauthenticated, error: errors, format: :json
      expect(json['error']).to eq(errors)
    end
  end

  context 'create' do
    let!(:staff) { create :staff, password: password }
    it 'creates new user session' do
      expect {
        login(staff.email, password)
      }.to change {
        request.env['warden'].user.nil?
      }.from(true).to(false)
    end
  end

  context 'destroy' do
    let!(:staff) { create :staff, password: password }

    it 'destroys user session' do
      login staff.email, password
      expect { logout }.to change { request.env['warden'].user.nil? }.from(false).to(true)
    end
  end
end
