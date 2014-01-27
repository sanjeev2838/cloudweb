class DiariesController < ApplicationController

  def index
    @diaries = Diary.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @diaries }
    end
  end

  def show
    @diary = Diary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @diary }
    end
  end

  def new
    @diary = Diary.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @diary }
    end
  end

  def create
    @diary = Diary.new(diary_params)

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

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy

    respond_to do |format|
      format.html { redirect_to diaries_url }
      format.json { head :no_content }
    end
  end

  private
    def diary_params
      params.require(:diary).permit(:diary)
    end
end
