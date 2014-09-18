class ProfilesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :find_vendor

  def index
    @product = Product.find(params[:product_id])
    @profiles = Profile.all

    respond_to do |format|
      format.html
      format.json { render json: @profiles }
    end
  end

  def show
    @product = Product.find(params[:product_id])
    @profile = Profile.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @profile }
    end
  end

  def new
    @product = Product.find(params[:product_id])
    @profile = @product.profiles.new

    respond_to do |format|
      format.html
      format.json { render json: @profile }
    end
  end

  def edit
    @product = Product.find(params[:product_id])
    @profile = Profile.find(params[:id])
  end

  def create
    @product = Product.find(params[:product_id])
    @profile = @product.profiles.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to vendor_product_path(@vendor, @product), notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:product_id])
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(profile_params)
        format.html { redirect_to vendor_product_path(@vendor, @product), notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to vendor_product_path(@vendor, @product) }
      format.json { head :no_content }
    end
  end

  private

    def find_vendor
      @vendor =  Vendor.find(params[:vendor_id])
    end

    def profile_params
      params.require(:profile).permit(:key_32, :key_33, :key_34, :key_35, :key_36, :key_37, :key_38, :key_39, :key_40, :key_41, :key_42, :key_43, :key_44, :key_45, :key_46, :key_47, :key_48, :key_49, :key_50, :volume)
    end
end
