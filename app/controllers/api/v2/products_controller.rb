class Api::V2::ProductsController < Api::Default::BaseController
  before_filter :find_vendor

  def product_profiles
    @product = Product.find(params[:productid])
    @profiles  =  @product.profiles
    if  @profiles.blank?
      render json:{:status => false, :message => "No product preferences found for this Id"}
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
