# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'swagger#index'

  # Swagger documentation
  draw :swagger

  # API routes
  defaults format: :json do
    # V1
    namespace :v1 do
      draw :authentication
    end
  end
end
