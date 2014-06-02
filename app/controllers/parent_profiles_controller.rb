class ParentProfilesController < ApplicationController

  def index
    @parent_profiles = ParentProfile.where(:status => true)
    respond_to do |format|
      format.html
      format.json { render json: @parent_profiles }
    end
  end

  def show
    @parent_profile = ParentProfile.find(params[:id])
    @machine = Machine.find_by_id(@parent_profile.machine_id) unless @parent_profile.nil?
    respond_to do |format|
      format.html
      format.json { render json: @parent_profile }
    end
  end

  def new
    @parent_profile = ParentProfile.new
    @languages = ParentProfile::LANG
    respond_to do |format|
      format.html
      format.json { render json: @parent_profile }
    end
  end

  def edit
    @parent_profile = ParentProfile.find(params[:id])
  end

  def create
    params[:parent_profile] = (params[:parent_profile]).merge(:status => true)
    @parent_profile = ParentProfile.new(params[:parent_profile])

    respond_to do |format|
      if @parent_profile.save
        format.html { redirect_to @parent_profile, notice: 'Parent profile was successfully created.' }
        format.json { render json: @parent_profile, status: :created, location: @parent_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @parent_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @parent_profile = ParentProfile.find(params[:id])

    respond_to do |format|
      if @parent_profile.update_attributes(params[:parent_profile])
        format.html { redirect_to @parent_profile, notice: 'Parent profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @parent_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @parent_profile = ParentProfile.find(params[:id])
    @parent_profile.update_column(:status , false)

    respond_to do |format|
      format.html { redirect_to parent_profiles_url }
      format.json { head :no_content }
    end
  end

  def make_machine_owner
    @parent_profile =  ParentProfile.find(params[:format])
    if @parent_profile.update_attributes(:is_machine_owner=>true)
       redirect_to  @parent_profile ,notice: 'Parent profile was successfully updated.'
    else
      redirect_to  @parent_profile ,notice: 'Parent profile was not  updated.'
    end

  end
end
