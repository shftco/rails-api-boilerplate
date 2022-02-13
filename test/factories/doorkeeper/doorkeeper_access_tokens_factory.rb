# frozen_string_literal: true

FactoryBot.define do
  factory :doorkeeper_access_token, class: 'Doorkeeper::AccessToken' do
    association :application, factory: :doorkeeper_application
    expires_in { 1.hour }
    association :resource_owner, factory: :user
    sequence :refresh_token do |n|
      SecureRandom.hex(32) + n.to_s
    end
  end
end
