require 'rails_helper'

describe 'Templates routes', type: :routing do
  it 'routes to templates controller on /' do
    expect(get: '/').to route_to(
      controller: 'templates',
      action: 'index'
    )
  end

  it 'routes to templates controller on /t/:template' do
    expect(get: '/t/name').to route_to(
      controller: 'templates',
      action: 'index',
      template: 'name'
    )
  end
end
