Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  resources :tickets, only: [:create, :update, :show, :index]

  root 'templates#index'

  get '/t/:template', controller: :templates, action: :index
  get '/unauthenticated', controller: :sessions, action: :unauthenticated
end
