class TransportsController < ApplicationController
  before_action :set_transport, only: %i[ show edit update destroy ]

  # GET /transports or /transports.json
  def index
    @transports = Transport.all
  end

  # GET /transports/1 or /transports/1.json
  def show
  end

  # GET /transports/new
  def new
    @transport = Transport.new
  end

  # GET /transports/1/edit
  def edit
  end

  # POST /transports or /transports.json
  def create
    @transport = Transport.new(transport_params)

    respond_to do |format|
      if @transport.save
        format.html { redirect_to transport_url(@transport) }
        format.json { render :show, status: :created, location: @transport }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transports/1 or /transports/1.json
  def update
    respond_to do |format|
      if @transport.update(transport_params)
        format.html { redirect_to transport_url(@transport) }
        format.json { render :show, status: :ok, location: @transport }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transports/1 or /transports/1.json
  def destroy
    @transport.destroy

    respond_to do |format|
      format.html { redirect_to transports_url }
      format.json { head :no_content }
    end
  end

  def list_for_payments
    @transports = Transport.all  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transport
      @transport = Transport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transport_params
      params.require(:transport).permit(:name, :to_date, :insurance_date, :description)
    end
end
