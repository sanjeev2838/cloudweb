class Api::V2::ProductsController < Api::Default::BaseController
  before_filter :find_vendor

  def product_preferences
    @product = Product.find(params[:productid])
    @preferences =  @product.child_brewing_preferences
    if  @preferences.blank?
      render json:{:status => false, :message => "No product preferences found for this name"}
    end
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find product As per given Id  on cloud"}
  end

  private

  def find_vendor
    @vendor = Vendor.find(params[:supplierid])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find vendor As per given Id  on cloud"}
  end

end
