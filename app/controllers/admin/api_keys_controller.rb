# app/controllers/admin/api_keys_controller.rb
class Admin::ApiKeysController < Admin::BaseController
  def index
    @api_keys = current_user.organisation.api_keys.order(created_at: :desc)
  end

  def create
    current_user.organisation.api_keys.create!(name: "Generated #{Time.zone.now.to_s(:short)}")
    redirect_to admin_dashboard_path, notice: "New API token generated."
  end

  def destroy
    key = current_user.organisation.api_keys.find(params[:id])
    key.destroy!
    redirect_to admin_dashboard_path, notice: "Token revoked."
  end
end
