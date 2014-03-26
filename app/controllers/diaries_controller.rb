class DiariesController < ApplicationController
  # GET /diaries
  # GET /diaries.json
   include DiariesHelper
  def index
    @diaries = Diary.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @diaries }
    end
  end

  # GET /diaries/1
  # GET /diaries/1.json
  def show
    @diary = Diary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @diary }
    end
  end

  # GET /diaries/new
  # GET /diaries/new.json
  def new
    @diary = Diary.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @diary }
    end
  end

  # GET /diaries/1/edit
  def edit
    @diary = Diary.find(params[:id])
  end

  # POST /diaries
  # POST /diaries.json
  def create
    @diary = Diary.new(params[:diary])

    respond_to do |format|
      if @diary.save
        format.html { redirect_to @diary, notice: 'Diary was successfully created.' }
        format.json { render json: @diary, status: :created, location: @diary }
      else
        format.html { render action: "new" }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diaries/1
  # PATCH/PUT /diaries/1.json
  def update
    @diary = Diary.find(params[:id])

    respond_to do |format|
      if @diary.update_attributes(diary_params)
        format.html { redirect_to @diary, notice: 'Diary was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diaries/1
  # DELETE /diaries/1.json
  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy

    respond_to do |format|
      format.html { redirect_to diaries_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    #def diary_params
    #  params.require(:diary).permit()
    #end
end
