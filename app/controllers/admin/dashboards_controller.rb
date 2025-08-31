# app/controllers/admin/dashboards_controller.rb
class Admin::DashboardsController < Admin::BaseController
  def show
    @organisation = current_user.organisation
    @api_keys     = @organisation.api_keys.order(created_at: :desc)
    @projects     = @organisation.projects.order(:name)


    # Use an env var in prod; fall back to request in dev
    @base_url = ENV["PUBLIC_BASE_URL"].presence || "#{request.base_url}/api/v1"
  end
end
