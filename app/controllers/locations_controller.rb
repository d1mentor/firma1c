class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]

  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end

  # GET /
  def dashboard
    @@MONTHS = %w[Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь]
    payments = Payment.all.group_by { |m| m.created_at.beginning_of_month }
    
    puts payments.first
  end

  def days_ranges(year)
    (1..12).to_a.reduce([]) { |result, month_number| result << (1..Date.new(year, month_number, -1).day) }
  end

  # GET /locations/1 or /locations/1.json
  def show; end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit; end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to location_url(@location) }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to location_url(@location) }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def location_params
    params.require(:location).permit(:name, :adress, :description, :flag, :photos_url)
  end
end
