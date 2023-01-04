class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[ show edit update destroy ]
  
  # GET /payments or /payments.json
  def index
    @payments = Payment.where(capital: false, date: filter[:start_date].to_date..filter[:end_date].to_date ).order(:date).reverse
  
    @payments = filter_payments_by_category(@payments, filter)
    @payments = filter_payments_by_payment_type(@payments, filter)
    @payments = filter_payments_by_source_name(@payments, filter)
    @payments = filter_payments_by_payment_tag(@payments, filter)
  
    @sources = @payments.map { |payment| payment.source }.compact.uniq.reject { |source| source.class.name == "Supply" }
    @payment_tags = PaymentTag.all

    @kassa = @payments.sum(&:size)
  end

  def capital
    @payments = Payment.where(capital: true, date: filter[:start_date].to_date..filter[:end_date].to_date).order(:date).reverse
    
    @payments = filter_payments_by_category(@payments, filter)
    @payments = filter_payments_by_payment_type(@payments, filter)
    @payments = filter_payments_by_source_name(@payments, filter)
    @payments = filter_payments_by_payment_tag(@payments, filter)
  
    @sources = @payments.map { |payment| payment.source }.compact.uniq.reject { |source| source.class.name == "Supply" }
    @payment_tags = PaymentTag.all

    @capital = @payments.sum(&:size)
  end

  # GET /payments/1 or /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments or /payments.json
  def create
    @payment = Payment.new(payment_params.slice(:date, :size, :description, :source_type, :source_id, :capital, :payment_tag_id))

    if payment_params[:payment_type] == "Приход"
      @payment.size = @payment.size.abs
    else  
      @payment.size = -@payment.size.abs
    end  

    if payment_params[:date] == ""
      @payment.date = Date.today
    end  

    respond_to do |format|
      if @payment.save
        format.html { redirect_to payment_url(@payment) }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params.slice(:date, :size, :description, :source_type, :source_id, :capital, :payment_tag_id))
        if payment_params[:payment_type] == "Приход"
          @payment.update(size: @payment.size.abs)
        else  
          @payment.update(size: -@payment.size.abs)
        end  
        format.html { redirect_to payment_url(@payment) }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url }
      format.json { head :no_content }
    end
  end

  #before new action, choose the source type
  def choose
  end

  private
  def filter_payments_by_category(payments, filter)
    if filter[:category].present? && filter[:category] != "Н/Д"
      payments.select { |payment| payment.source_type == filter[:category] }
    elsif filter[:category] == "Н/Д"
      payments.reject { |payment| payment.source }
    else
      payments
    end
  end
  
  def filter_payments_by_payment_type(payments, filter)
    if filter[:filter_payment_type].present?
      if filter[:filter_payment_type] == 'Приход'
        payments.select { |payment| payment.size > 0 }
      else
        payments.select { |payment| payment.size < 0 }
      end
    else
      payments
    end
  end
  
  def filter_payments_by_source_name(payments, filter)
    if filter[:filter_source_name].present?
      payments.select do |payment|
        payment.source.class.name != "Supply" && payment.source&.name == filter[:filter_source_name]
      end
    else
      payments
    end
  end
  
  def filter_payments_by_payment_tag(payments, filter)
    if filter[:filter_payment_tag_id].present?
      payments.select { |payment| payment.payment_tag&.name == PaymentTag.find_by(name: filter[:filter_payment_tag_id]).name }
    else
      payments
    end
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def filter
      if params[:start_date] != '' && params[:start_date] != nil
        start = params[:start_date]
      else  
        start = Date.new(2003, 3, 23)
      end
      
      if params[:end_date] != '' && params[:end_date] != nil
        konets = params[:end_date]
      else  
        konets = Date.new(2053, 3, 23)
      end  

      { start_date: start,
        end_date: konets,
        filter_payment_type: params[:filter_payment_type],
        category: params[:category],
        filter_source_name: params[:filter_source_id],
        filter_payment_tag_id: params[:filter_payment_tag_id] }
        
    end  

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:date, :size, :description, :source_type, :source_id, :capital, :payment_type, :payment_tag_id)
    end
end
