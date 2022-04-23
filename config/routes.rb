# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'swagger#index'

  # Swagger documentation
  scope :swagger, as: 'swagger' do
    get '/', to: 'swagger#index', as: :root
    get '/data', to: 'swagger#data', as: :data
  end

  draw :authentication

  defaults format: :json do
    # API routes
  end
end
