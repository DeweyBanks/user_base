require 'api_constraints'
Rails.application.routes.draw do

  devise_for :users
  root 'welcome#index'

  #api
  namespace :api, defaults: { format: :json },
              constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
              constraints: ApiConstraints.new(version: 1, default: true) do
      resources :posts, only: [:index, :create, :update, :delete, :show]
      resources :users, :only => [:show, :create, :update]
    end
  end
end






