class PaymentTagsController < ApplicationController
  before_action :set_payment_tag, only: %i[ show edit update destroy ]

  # GET /payment_tags or /payment_tags.json
  def index
    @payment_tags = PaymentTag.all
  end

  # GET /payment_tags/1 or /payment_tags/1.json
  def show
  end

  # GET /payment_tags/new
  def new
    @payment_tag = PaymentTag.new
  end

  # GET /payment_tags/1/edit
  def edit
  end

  # POST /payment_tags or /payment_tags.json
  def create
    @payment_tag = PaymentTag.new(payment_tag_params)

    respond_to do |format|
      if @payment_tag.save
        format.html { redirect_to payment_tag_url(@payment_tag), notice: "Payment tag was successfully created." }
        format.json { render :show, status: :created, location: @payment_tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_tags/1 or /payment_tags/1.json
  def update
    respond_to do |format|
      if @payment_tag.update(payment_tag_params)
        format.html { redirect_to payment_tag_url(@payment_tag), notice: "Payment tag was successfully updated." }
        format.json { render :show, status: :ok, location: @payment_tag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_tags/1 or /payment_tags/1.json
  def destroy
    @payment_tag.destroy

    respond_to do |format|
      format.html { redirect_to payment_tags_url, notice: "Payment tag was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_tag
      @payment_tag = PaymentTag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_tag_params
      params.require(:payment_tag).permit(:name, :payment_id, :comment)
    end
end
