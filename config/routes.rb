require 'api_constraints'
Rails.application.routes.draw do

  devise_for :users
  root 'welcome#index'

  # namespace :api, defaults: { format: :json } do
  #   scope module: :v1,
  #             constraints: ApiConstraints.new(version: 1, default: true) do
  #     # We are going to list our resources here

  #     resources :posts, only: [:index, :create, :update, :delete, :show]
  #   end
  # end

   namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
              constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :posts, only: [:index, :create, :update, :delete, :show]
      resources :users, :only => [:show]
    end
  end
end







