# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "swagger#index"

  # Swagger documentation
  scope :swagger, as: 'swagger' do
    get "/", to: "swagger#index", as: :root
    get "/data", to: "swagger#data", as: :data
  end

  defaults format: :json do
    # API routes
  end
end
