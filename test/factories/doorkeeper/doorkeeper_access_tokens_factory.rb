# frozen_string_literal: true

FactoryBot.define do
  factory :doorkeeper_access_token, class: 'Doorkeeper::AccessToken' do
    application_id { create(:doorkeeper_application).id }
    expires_in { 1.hour }
    association :resource_owner, factory: :user
  end
end
