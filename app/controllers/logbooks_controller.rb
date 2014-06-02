class LogbooksController < ApplicationController

  def index
    @logbooks = Logbook.all

    respond_to do |format|
      format.html
      format.json { render json: @logbooks }
    end
  end

  def show
    @logbook = Logbook.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @logbook }
    end
  end

  def new
    @logbook = Logbook.new

    respond_to do |format|
      format.html
      format.json { render json: @logbook }
    end
  end

  def edit
    @logbook = Logbook.find(params[:id])
  end

  def create
    @logbook = Logbook.new(params[:logbook])

    respond_to do |format|
      if @logbook.save
        format.html { redirect_to @logbook, notice: 'Logbook was successfully created.' }
        format.json { render json: @logbook, status: :created, location: @logbook }
      else
        format.html { render action: "new" }
        format.json { render json: @logbook.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @logbook = Logbook.find(params[:id])

    respond_to do |format|
      if @logbook.update_attributes(params[:logbook])
        format.html { redirect_to @logbook, notice: 'Logbook was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @logbook.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @logbook = Logbook.find(params[:id])
    @logbook.destroy
    redirect_to :back
  end
end
