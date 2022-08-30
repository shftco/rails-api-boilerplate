# frozen_string_literal: true

class SwaggerDocs
  include Swagger::Blocks

  SWAGGERED_CLASSES = [
    ## Controllers ##
    Controllers::Users::TokensController,
    Controllers::Users::RegistrationsController,
    Controllers::Users::PasswordsController,
    ## Models ##
    Models::Pagination,
    Models::Meta,
    ## Inputs ##
    Inputs::User::SignInInput,
    Inputs::User::SignUpInput,
    Inputs::User::ResetPasswordInput,
    Inputs::User::UpdatePasswordInput,
    Inputs::User::RevokeInput,
    ## Responses ##
    Responses::User::SignInResponse,
    Responses::User::SignUpResponse,
    Responses::User::ResetPasswordResponse,
    Responses::User::UpdatePasswordResponse,
    Responses::ErrorResponse,
    self
  ].freeze

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
      url_options = Rails.application.routes.default_url_options
      key :url, "#{url_options[:protocol]}://#{url_options[:host]}"
      key :description, 'Rails API Boilerplate'
    end
  end

  class << self
    def swagger_root
      swagger_data = Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)

      swagger_data[:components][:securitySchemes] = {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT'
        }
      }

      swagger_data[:security] = [{ bearerAuth: [] }]

      swagger_data
    end
  end
end
