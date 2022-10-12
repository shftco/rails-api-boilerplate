# frozen_string_literal: true

class SwaggerController < ApplicationController
  def index
    render html: nil, layout: 'layouts/swagger'
  end

  def v1_data
    swagger_data = SwaggerDocs.v1_swagger_root

    render json: swagger_data, status: :ok
  end

  def v2_data
    swagger_data = SwaggerDocs.v2_swagger_root

    render json: swagger_data, status: :ok
  end
end
