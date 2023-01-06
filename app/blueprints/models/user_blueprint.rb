# frozen_string_literal: true

module Models
  class UserBlueprint < Blueprinter::Base
    identifier :id

    view :standard do
      fields :email, :created_at, :updated_at
    end

    view :with_devise_trackable do
      fields :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
    end
  end
end
