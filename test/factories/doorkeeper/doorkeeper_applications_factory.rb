# frozen_string_literal: true

FactoryBot.define do
  factory :doorkeeper_application, class: 'Doorkeeper::Application' do
    name { Faker::App.name }
    redirect_uri { '' }
    scopes { '' }
  end
end
