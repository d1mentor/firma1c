class NoticesController < ApplicationController
  before_action :set_notice, only: %i[ show edit update destroy ]

  # GET /notices/new
  def new
    @notice = Notice.new
  end

  # GET /notices/1/edit
  def edit
  end

  # POST /notices or /notices.json
  def create
    @notice = Notice.new(notice_params)
    @notice.save
    redirect_to "/locations/#{@notice.location_id}"  
  end

  # PATCH/PUT /notices/1 or /notices/1.json
  def update
    @notice.update(notice_params)
    redirect_to "/locations/#{@notice.location_id}" 
  end

  # DELETE /notices/1 or /notices/1.json
  def destroy
    @notice.destroy
    redirect_to "/locations/#{@notice.location_id}" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notice
      @notice = Notice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notice_params
      params.require(:notice).permit(:text, :location_id)
    end
end
