class SnagsController < ApplicationController
  before_action :set_snag, only: %i[ show edit update destroy ]

  # GET /snags or /snags.json
  def index
    @snags = Snag.all
  end

  # GET /snags/1 or /snags/1.json
  def show
  end

  # GET /snags/new
  def new
    @snag = Snag.new
  end

  # GET /snags/1/edit
  def edit
  end

  # POST /snags or /snags.json
  def create
    @snag = Snag.new(snag_params)

    respond_to do |format|
      if @snag.save
        format.html { redirect_to @snag, notice: "Snag was successfully created." }
        format.json { render :show, status: :created, location: @snag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @snag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snags/1 or /snags/1.json
  def update
    respond_to do |format|
      if @snag.update(snag_params)
        format.html { redirect_to @snag, notice: "Snag was successfully updated." }
        format.json { render :show, status: :ok, location: @snag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @snag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snags/1 or /snags/1.json
  def destroy
    @snag.destroy!

    respond_to do |format|
      format.html { redirect_to snags_path, status: :see_other, notice: "Snag was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snag
      @snag = Snag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def snag_params
      params.require(:snag).permit(:project_id, :location, :description, :created_by)
    end
end
