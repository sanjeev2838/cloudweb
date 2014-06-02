class DiariesController < ApplicationController
   include DiariesHelper
  def index
    @diaries = Diary.all

    respond_to do |format|
      format.html
      format.json { render json: @diaries }
    end
  end

  def show
    @diary = Diary.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @diary }
    end
  end

  def new
    @diary = Diary.new

    respond_to do |format|
      format.html
      format.json { render json: @diary }
    end
  end

  def edit
    @diary = Diary.find(params[:id])
  end

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
    redirect_to :back
  end

end
