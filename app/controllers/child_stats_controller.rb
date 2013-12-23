class ChildStatsController < ApplicationController
  # GET /child_stats
  # GET /child_stats.json
  def index
    @child_stats = ChildStat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @child_stats }
    end
  end

  # GET /child_stats/1
  # GET /child_stats/1.json
  def show
    @child_stat = ChildStat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @child_stat }
    end
  end

  # GET /child_stats/new
  # GET /child_stats/new.json
  def new
    @child_stat = ChildStat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @child_stat }
    end
  end

  # GET /child_stats/1/edit
  def edit
    @child_stat = ChildStat.find(params[:id])
  end

  # POST /child_stats
  # POST /child_stats.json
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

  # PUT /child_stats/1
  # PUT /child_stats/1.json
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

  # DELETE /child_stats/1
  # DELETE /child_stats/1.json
  def destroy
    @child_stat = ChildStat.find(params[:id])
    @child_stat.destroy

    respond_to do |format|
      format.html { redirect_to child_stats_url }
      format.json { head :no_content }
    end
  end
end
