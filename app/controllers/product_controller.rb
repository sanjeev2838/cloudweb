class ProductController < ApplicationController
  def index
    @vendor = Vendor.find(params[:vendor_id])
    @vendor_products = @vendor.products

    respond_to do |format|
      format.html
      format.json { render json: @vendor_products }
    end
  end

  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @product }
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to vendor_index_url }
      format.json { head :no_content }
    end
  end

  def new
    @product = Product.new

    respond_to do |format|
      format.html
      format.json { render json: vendor_index_path }
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @vendor = Vendor.find(params[:vendor_id])
    @product = @vendor.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to vendor_product_index_path, notice: 'Product was successfully created.' }
        format.json { render json: vendor_product_index_path, status: :created, location: @product }
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
        format.html { redirect_to vendor_product_index_path, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def product_params
    params.require(:product).permit(:name)
  end
end
