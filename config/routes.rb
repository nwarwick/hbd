# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api' do
    resources :users
    resources :teams
  end

  post '/slack/command', to: 'slack/commands#create'
  post '/slack/interaction', to: 'slack/commands#interaction'
  get '/slack/health-checkup', to: 'slack/commands#checkup'
end
