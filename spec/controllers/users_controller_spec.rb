require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let :resource_name do
    'users'
  end

  let :resource_params do
    {
      email: 'the-eaail@domain.com',
      name: 'thename',
      password: 'coolpass'
    }
  end

  it_behaves_like 'json resource'
end
