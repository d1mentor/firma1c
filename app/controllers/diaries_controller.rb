class DiariesController < ApplicationController
  before_action :set_diary, only: %i[ show edit update destroy ]

  def index
    puts filter[:start_date]
    puts filter[:end_date]
    @diaries = Diary.where(date: filter[:start_date]..filter[:end_date]).reverse


    @locations = []

    @diaries.each do |diary|
      @locations << { "name" => "#{diary.work.location.name}" }
    end  

    @works = []

    @diaries.each do |diary|
      @works << { "name" => "#{diary.work.name}" }
    end  

    @workers = []

    @diaries.each do |diary|
      @workers << { "name" => "#{diary.worker.name}" }
    end  

    @locations = @locations.uniq
    @workers = @workers.uniq
    @works = @works.uniq

    unvalid_diaries = []

    if filter[:filter_location] != nil && filter[:filter_location] != ""
      @diaries.each do |diary|
        if diary.work.location.name != filter[:filter_location]
          unvalid_diaries << diary
        end  
      end  
    end

    if filter[:filter_work] != nil && filter[:filter_work] != ""
      @diaries.each do |diary|
        if diary.work.name != filter[:filter_work]
          unvalid_diaries << diary
        end  
      end  
    end

    if filter[:filter_worker] != nil && filter[:filter_worker] != ""
      @diaries.each do |diary|
        if diary.worker.name != filter[:filter_worker]
          unvalid_diaries << diary
        end  
      end  
    end

    @diaries = @diaries - unvalid_diaries.uniq
  end

  # GET /diaries/1 or /diaries/1.json
  def show
  end

  # GET /diaries/new
  def new
    @diary = Diary.new
  end

  # GET /diaries/1/edit
  def edit
  end

  # POST /diaries or /diaries.json
  def create
    @diary = Diary.new(diary_params)

    respond_to do |format|
      if @diary.save
        format.html { redirect_to diary_url(@diary) }
        format.json { render :show, status: :created, location: @diary }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diaries/1 or /diaries/1.json
  def update
    respond_to do |format|
      if @diary.update(diary_params)
        format.html { redirect_to diary_url(@diary) }
        format.json { render :show, status: :ok, location: @diary }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diaries/1 or /diaries/1.json
  def destroy
    @diary.destroy

    respond_to do |format|
      format.html { redirect_to diaries_url }
      format.json { head :no_content }
    end
  end

  private

    def filter
      if params[:start_date] != '' && params[:start_date] != nil
        start = Date.parse(params[:start_date])
      else  
        start = Date.new(2003, 3, 23)
      end
      
      if params[:end_date] != '' && params[:end_date] != nil
        konets = Date.parse(params[:end_date])
      else  
        konets = Date.new(2053, 3, 23)
      end  

      { start_date: start,
        end_date: konets,
        filter_location: params[:filter_location],
        filter_work: params[:filter_work],
        filter_worker: params[:filter_worker] }    
    end  

    # Use callbacks to share common setup or constraints between actions.
    def set_diary
      @diary = Diary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def diary_params
      params.require(:diary).permit(:worker_id, :work_id, :completed_work_size, :date, :description, :hours)
    end
end
