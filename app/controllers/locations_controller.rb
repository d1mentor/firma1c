class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]

  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end

  # GET /
  def dashboard
    @@MONTHS = %w[Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь]
    payments_for_months = Payment.where(capital: false).group_by { |m| m.date.beginning_of_month }
    
    @payments_stats = []
    
    payments_for_months.each do |payments_for_month|
      humanread_date = @@MONTHS[payments_for_month.first.month - 1] + ' ' + payments_for_month.first.year.to_s 
      total = (payments_for_month.last.sum { |payment| payment.size }) 
      plus = 0 
      payments_for_month.last.each { |payment| plus += payment.size if payment.size >= 0 }
      minus = 0
      payments_for_month.last.each { |payment| minus += payment.size if payment.size < 0 }
      dynamic = 0

      if @payments_stats.size != 0
        percent = @payments_stats.last[:total]/100 
        dynamic = (((total - @payments_stats.last[:total])/percent).abs).round(2) 

        dynamic *= -1 if total < @payments_stats.last[:total]
      end  

      @payments_stats << {
        month: humanread_date,
        payments_count: payments_for_month.last.size,
        plus: plus,
        minus: minus,
        total: total,
        dynamic: dynamic
      }
    end 

    payments_for_months = Payment.where(capital: true).group_by { |m| m.date.beginning_of_month }
    
    @capital_stats = []
    
    payments_for_months.each do |payments_for_month|
      humanread_date = @@MONTHS[payments_for_month.first.month - 1] + ' ' + payments_for_month.first.year.to_s 
      total = (payments_for_month.last.sum { |payment| payment.size }) 
      dynamic = 0

      if @capital_stats.size != 0
        percent = total/100 
        dynamic = (((total - @payments_stats.last[:total])/percent).abs).round(2) 
        dynamic *= -1 if total < @payments_stats.last[:total]
      end  

      @capital_stats << {
        month: humanread_date,
        payments_count: payments_for_month.last.size,
        total: total,
        dynamic: dynamic
      }
    end 
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
