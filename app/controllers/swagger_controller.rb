# frozen_string_literal: true

# rubocop:disable Rails/ApplicationController
class SwaggerController < ActionController::Base
  include Swagger::Blocks

  swagger_root do
    key :openapi, '3.0.0'

    info do
      key :version, '1.0.0'
      key :title, 'Rails API Boilerplate'
      key :description, 'Rails API Boilerplate'

      contact do
        key :name, 'SHFT'
        key :url, 'https://shft.co'
        key :email, 'contact@shft.co'
      end
    end

    server do
      key :url, (Rails.env.development? ? 'http://localhost:3000' : 'https://api.rails.boilerplate').to_s
      key :description, 'Rails API Boilerplate'
    end
  end

  SWAGGERED_CLASSES = [
    ## Controllers ##
    Swagger::Controllers::Users::TokensController,
    Swagger::Controllers::Users::RegistrationsController,
    Swagger::Controllers::Users::PasswordsController,
    ## Models ##
    Swagger::Models::Pagination,
    Swagger::Models::Meta,
    ## Inputs ##
    Swagger::Inputs::User::SignInInput,
    Swagger::Inputs::User::SignUpInput,
    Swagger::Inputs::User::ResetPasswordInput,
    Swagger::Inputs::User::UpdatePasswordInput,
    ## Responses ##
    Swagger::Responses::User::SignInResponse,
    Swagger::Responses::User::SignUpResponse,
    Swagger::Responses::User::ResetPasswordResponse,
    Swagger::Responses::User::UpdatePasswordResponse,
    self
  ].freeze

  def index
    render html: nil, layout: 'layouts/swagger'
  end

  def data
    render json: swagger_data, status: :ok
  end

  private

  def swagger_data
    swagger_data = Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)

    swagger_data[:components][:securitySchemes] = {
      bearerAuth: {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT'
      }
    }

    swagger_data
  end
end
# rubocop:enable Rails/ApplicationController
