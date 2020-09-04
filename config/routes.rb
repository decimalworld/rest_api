require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users, :only => []
  namespace :api , defaults: { format: :json }, path: '/' do
    scope module: :v1 do
      # constraints: ApiConstraints.new(version: 1, defaults: true) do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :products, :only => [:show, :index] 
    end
  end
end
