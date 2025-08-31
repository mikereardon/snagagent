# app/controllers/api/v1/base_controller.rb
module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :ensure_json!
      before_action :authenticate_api_key!

      attr_reader :current_organisation

      rescue_from ActionController::ParameterMissing do |e|
        render json: { error: e.message }, status: :bad_request
      end

      rescue_from StandardError do |e|
        Rails.logger.error("[API] #{e.class}: #{e.message}\n#{e.backtrace&.first(5)&.join("\n")}")
        render json: { error: "Internal server error" }, status: :internal_server_error
      end

      private

      def ensure_json!
        request.format = :json
      end

      # Expect header: Authorization: Bearer <TOKEN>
      def authenticate_api_key!
        token = request.headers["Authorization"].to_s.split("Bearer ").last
        head :unauthorized and return if token.blank?
        key = ApiKey.find_by(token: token)
        head :unauthorized and return unless key
        @current_organisation = key.organisation
      end
    end
  end
end
