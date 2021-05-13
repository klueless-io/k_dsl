# frozen_string_literal: true

# config/routes.rb
#
# source: https://mattboldt.com/separate-rails-route-files/
#
Rails.application.routes.draw do
  # Devise Routes
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Starter Routes
  get "/", to: "pages#home"
  get "readme", to: "pages#readme"
  get "architecture", to: "pages#architecture"

  # API V1 Routes
  draw :api_v1
end
