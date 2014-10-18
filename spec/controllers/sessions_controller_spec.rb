require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
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
end
