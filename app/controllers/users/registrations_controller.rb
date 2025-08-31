# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]

  def create
    build_resource(sign_up_params)
    resource.role = "admin" # admin-only signup

    ActiveRecord::Base.transaction do
      org_name = params.dig(:user, :organisation_name).to_s.strip
      raise ActiveRecord::RecordInvalid, "Organisation name required" if org_name.blank?

      org = Organisation.create!(name: org_name)
      resource.organisation = org
      resource.save!  # persist the admin user

      ApiKey.create!(organisation: org, name: "Default")
    end

    if resource.persisted?
      sign_up(resource_name, resource)
      redirect_to admin_dashboard_path, notice: "Welcome! Your organisation and API key are ready."
    else
      clean_up_passwords resource
      render :new, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.message
    clean_up_passwords resource
    render :new, status: :unprocessable_entity
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :organisation_name ])
  end
end
