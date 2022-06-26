# frozen_string_literal: true

class SwaggerController < ApplicationController
  def index
    render html: nil, layout: 'layouts/swagger'
  end

  def data
    swagger_data = SwaggerDocs.swagger_root

    render json: swagger_data, status: :ok
  end
end
