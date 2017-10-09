require 'api_constraints'
Rails.application.routes.draw do

  devise_for :users
  root 'welcome#index'

  #api
  namespace :api, defaults: { format: :json },
              constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
              constraints: ApiConstraints.new(version: 1, default: true) do
      resources :posts, only: [:index, :create, :update, :destroy, :show]
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
    end
  end
end







