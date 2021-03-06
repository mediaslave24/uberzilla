require 'rails_helper'

RSpec.describe DepartmentsController, :type => :controller do
  let :resource_name do
    'departments'
  end

  let :resource_params do
    { name: '123' }
  end

  it_behaves_like 'json resource'
end
