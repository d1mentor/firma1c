class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[ show edit update destroy ]

  # GET /payments or /payments.json
  def index
    @payments = Payment.where(capital: false, date: filter[:start_date]..filter[:end_date]).reverse
    unvalid_payments = []

    if filter[:category] != nil && filter[:category] != "" && filter[:category] != "Н/Д"
      @payments.each do |payment|
        if payment.source_type != filter[:category]
          unvalid_payments << payment
        end  
      end  
    end

    if filter[:category] == "Н/Д"
      @payments.each do |payment|
        if payment.source != nil
          unvalid_payments << payment
        end  
      end  
    end  

    if filter[:filter_payment_type] != nil && filter[:filter_payment_type] != ""
      if filter[:filter_payment_type] == 'Приход'
        @payments.each do |payment|
          if payment.size < 0
            unvalid_payments << payment
          end  
        end  
      else 
        @payments.each do |payment|
          if payment.size > 0
            unvalid_payments << payment
          end  
        end  
      end 
    end   

    if filter[:filter_source_name] != nil && filter[:filter_source_name] != ""
      @payments.each do |payment|
        if payment.source.class.name != "Supply"
          if payment.source == nil || payment.source.name != filter[:filter_source_name]
            unvalid_payments << payment
          end
        else
          unvalid_payments << payment
        end  
      end  
    end 

    @payments = @payments - unvalid_payments.uniq

    @sources = []

    @payments.each do |payment| # Источники для фильтра во вьюхе
      if payment.source_type != "" && payment.source_type != "Supply"
        @sources << { "name"=>"#{payment.source.name}", "id"=>"#{payment.source.id}" }
      end  
    end

    @sources = @sources.uniq

    @kassa = 0

    @payments.each do |payment|
      @kassa += payment.size
    end  
  end

  def capital
    @payments = Payment.where(capital: true).reverse
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
    @payment = Payment.new(payment_params.slice(:date, :size, :description, :source_type, :source_id, :capital))

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
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully created." }
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
      if @payment.update(payment_params.slice(:date, :size, :description, :source_type, :source_id, :capital))
        if payment_params[:payment_type] == "Приход"
          @payment.update(size: @payment.size.abs)
        else  
          @payment.update(size: -@payment.size.abs)
        end  
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully updated." }
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
      format.html { redirect_to payments_url, notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #before new action, choose the source type
  def choose
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def filter
      if params[:start_date] != ''
        start = params[:start_date]
      else  
        start = Date.new(2003, 3, 23)
      end
      
      if params[:end_date] != ''
        konets = params[:end_date]
      else  
        konets = Date.new(2053, 3, 23)
      end  

      { start_date: start,
        end_date: konets,
        filter_payment_type: params[:filter_payment_type],
        category: params[:category],
        filter_source_name: params[:filter_source_id] }
        
    end  

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:date, :size, :description, :source_type, :source_id, :capital, :payment_type)
    end
end
