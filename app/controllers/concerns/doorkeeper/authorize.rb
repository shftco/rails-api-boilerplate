# frozen_string_literal: true

module Doorkeeper::Authorize
  extend ActiveSupport::Concern

  included do
    before_action :find_doorkeeper_application!

    attr_reader :current_doorkeeper_application
  end

  private

  def find_doorkeeper_application!
    @current_doorkeeper_application = Doorkeeper::Application.find_by(uid: params[:client_id],
                                                                      secret: params[:client_secret])

    render json: { errors: invalid_client_message }, status: :unauthorized if @current_doorkeeper_application.blank?
  end

  def invalid_client_message
    [I18n.t('doorkeeper.errors.messages.invalid_client')]
  end
end
