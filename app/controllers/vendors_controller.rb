class VendorsController < ApplicationController

  def index
    @vendors = Vendor.all

    respond_to do |format|
      format.html
      format.json { render json: @vendors }
    end
  end

  def show
    @vendor = Vendor.find(params[:id])
    @vendor_products = @vendor.products

    respond_to do |format|
      format.html
      format.json { render json: @vendor_products }
    end
  end

  def destroy
    @vendor = Vendor.find(params[:id])
    @vendor.destroy

    respond_to do |format|
      format.html { redirect_to vendors_path }
      format.json { head :no_content }
    end
  end

  def new
    @vendor = Vendor.new

    respond_to do |format|
      format.html
      format.json { render json: vendors_path }
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def create
    @vendor = Vendor.new(vendor_params)

    respond_to do |format|
      if @vendor.save
        format.html { redirect_to vendors_path, notice: 'Vendor was successfully created.' }
        format.json { render json: vendors_path, status: :created, location: @vendor }
      else
        format.html { render action: "new" }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      if @vendor.update_attributes(vendor_params)
        format.html { redirect_to vendors_path, notice: 'Vendor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def vendor_params
    params.require(:vendor).permit(:name, :brew_type)
  end
end
