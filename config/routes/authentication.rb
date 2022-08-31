# frozen_string_literal: true

devise_for :users, skip: :all

namespace :users do
  use_doorkeeper do
    controllers tokens: 'tokens'
    skip_controllers :applications, :authorized_applications, :authorizations
  end
end

scope :users, module: :users do
  devise_scope :user do
    post 'sign_up', to: 'registrations#create', as: :user_registration
    post 'password', to: 'passwords#create', as: :user_password
    patch 'password', to: 'passwords#update', as: nil
  end
end
