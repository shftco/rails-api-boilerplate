# frozen_string_literal: true

devise_for :users, skip: :all

scope :users do
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications, :authorizations
  end

  scope module: :users do
    devise_scope :user do
      post 'sign_up', to: 'registrations#create', as: :user_registration
      post 'password', to: 'passwords#create', as: :user_password
      patch 'password', to: 'passwords#update', as: nil
    end
  end
end
