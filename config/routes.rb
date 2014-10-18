Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  resources :tickets, only: [:create, :update, :show, :index] do
    get :changelog, on: :member
  end

  with_options only: [:index, :create, :destroy, :update] do |draw|
    draw.resources :departments, :ticket_statuses, :users
  end

  root 'templates#index'

  get '/t/:template', controller: :templates, action: :index
  get '/unauthenticated', controller: :sessions, action: :unauthenticated
end
