class ProductsController < ApplicationController
  before_filter :find_vendor

  def index
    @vendor_products = @vendor.products

    respond_to do |format|
      format.html
      format.json { render json: @vendor_products }
    end
  end

  def show
    @product =  @vendor.products.find(params[:id]) || Product.find(params[:id])
    @product_profiles = []
    @product_profiles = @product.profiles if @product

    respond_to do |format|
      format.html
      format.json { render json: @product }
    end
  end

  def profile_row
    @product =  @vendor.products.find(params[:id])
    @profile = @product.profiles.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @product =  @vendor.products.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to vendor_path(@vendor) }
      format.json { head :no_content }
    end
  end

  def new
    @product = @vendor.products.new

    respond_to do |format|
      format.html
      format.json { render json: vendor_path }
    end
  end

  def edit
    @product =  @vendor.products.find(params[:id])
  end

  def create
    @product = @vendor.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to vendor_product_path(@vendor, @product), notice: 'Product was successfully created.' }
        format.json { render json: vendor_product_path, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(product_params)
        format.html { redirect_to vendor_product_path(@vendor, @product), notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :brew_type)
  end

  def find_vendor
    @vendor = Vendor.find(params[:vendor_id])
  end
end
