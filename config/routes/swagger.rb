# frozen_string_literal: true

scope :swagger, as: 'swagger' do
  get '/', to: 'swagger#index', as: :root
  get '/v1_data', to: 'swagger#v1_data', as: :v1_data
  get '/v2_data', to: 'swagger#v2_data', as: :v2_data
end
