class SuppliesController < ApplicationController
  before_action :set_supply, only: %i[ show edit update destroy ]

  # GET /supplies or /supplies.json
  def index
    @supplies = Supply.all.reverse
  end

  # GET /supplies/1 or /supplies/1.json
  def show
  end

  # GET /supplies/new
  def new
    @supply = Supply.new
  end

  # GET /supplies/1/edit
  def edit
  end

  # POST /supplies or /supplies.json
  def create
    @supply = Supply.new(supply_params)
    respond_to do |format|
      if @supply.save
        format.html { redirect_to supply_url(@supply) }
        format.json { render :show, status: :created, location: @supply }

        materials = params[:materials].permit!

        materials.each do |material|
          new_material = Material.new(material[1])
          new_material.supply = @supply
          if material[1]["name"] != "" && material[1]["count"] != "" && material[1]["dimension"] != "" 
            new_material.save
          end
        end  
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supplies/1 or /supplies/1.json
  def update
    respond_to do |format|
      if @supply.update(supply_params)
        format.html { redirect_to supply_url(@supply) }
        format.json { render :show, status: :ok, location: @supply }

        @supply.materials.each do |material|
          material.destroy
        end
          
        materials = params[:materials].permit!

        materials.each do |material|
        new_material = Material.new(material[1])
        new_material.supply = @supply
        new_material.save
      end  
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplies/1 or /supplies/1.json
  def destroy
    @supply.destroy

    respond_to do |format|
      format.html { redirect_to supplies_url }
      format.json { head :no_content }
    end
  end

  def list_for_payments
    @supplies = Supply.all  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supply
      @supply = Supply.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supply_params
      params.require(:supply).permit(:supplier_id, :location_id, :description, :date, materials: {})
    end
end
