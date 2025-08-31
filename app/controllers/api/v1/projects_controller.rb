# app/controllers/api/v1/projects_controller.rb
class Api::V1::ProjectsController < Api::V1::BaseController
  def index
    render json: current_organisation.projects.order(:id)
  end

  def show
    render json: current_organisation.projects.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Not found" }, status: :not_found
  end
end

# app/controllers/api/v1/snags_controller.rb
class Api::V1::SnagsController < Api::V1::BaseController
  def index
    snags = current_organisation.snags
    snags = snags.where(project_id: params[:project_id]) if params[:project_id].present?
    render json: snags.order(created_at: :desc)
  end

  def show
    render json: current_organisation.snags.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Not found" }, status: :not_found
  end

  def create
    project = current_organisation.projects.find(snag_params[:project_id])
    snag = current_organisation.snags.new(snag_params.merge(project: project))
    if snag.save
      render json: snag, status: :created
    else
      render json: { errors: snag.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Project not found" }, status: :unprocessable_entity
  end

  private

  def snag_params
    params.require(:snag).permit(:project_id, :location, :description, :created_by)
  end
end
