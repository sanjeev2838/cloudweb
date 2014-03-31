class ChildStatsController < ApplicationController

  def index
    @child_stats = ChildStat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @child_stats }
    end
  end

  def show
    @child_stat = ChildStat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @child_stat }
    end
  end

  def new
    @child_stat = ChildStat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @child_stat }
    end
  end

  def edit
    @child_stat = ChildStat.find(params[:id])
  end

  def create
    @child_stat = ChildStat.new(params[:child_stat])

    respond_to do |format|
      if @child_stat.save
        format.html { redirect_to @child_stat, notice: 'Child stat was successfully created.' }
        format.json { render json: @child_stat, status: :created, location: @child_stat }
      else
        format.html { render action: "new" }
        format.json { render json: @child_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @child_stat = ChildStat.find(params[:id])

    respond_to do |format|
      if @child_stat.update_attributes(params[:child_stat])
        format.html { redirect_to @child_stat, notice: 'Child stat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @child_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @child_stat = ChildStat.find(params[:id])
    @child_stat.destroy
    redirect_to :back

  end
end
