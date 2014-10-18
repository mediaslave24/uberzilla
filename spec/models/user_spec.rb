require 'rails_helper'

RSpec.describe User, :type => :model do
  context 'password' do
    before :context do
      @password = '123456'
      @user = create :user, password: @password
    end

    it 'is non-recoverable' do
      expect(@user.password.to_s).not_to eq(@password)
    end

    it 'is validatable' do
      expect(@user.password).to eq(@password)
    end
  end
end
