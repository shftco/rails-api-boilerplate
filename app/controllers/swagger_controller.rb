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
    Swagger::Models::Pagination,
    Swagger::Models::Meta,
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
    Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)

    # Add this lines if you are using oauth2
    # swagger_data[:components][:securitySchemes] = {
    #   bearerAuth: {
    #     type: 'http',
    #     scheme: 'bearer',
    #     bearerFormat: 'JWT'
    #   }
    # }
  end
end
# rubocop:enable Rails/ApplicationController
