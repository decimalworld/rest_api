require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  namespace :api , defaults: { format: :json }, path: '/' do
    scope module: :v1 do
      # constraints: ApiConstraints.new(version: 1, defaults: true) do
        resources :users, :only => [:show]
    end
  end
end
