class Api::V2::VendorsController < Api::Default::BaseController

  def vendors_as_per_brew_type
    @vendors = Vendor.find_all_by_brew_type(params[:brew_type])
    if @vendors.blank?
      render json:{:status => false, :message => "Unable to find any Supplier with given Brew type"}
    end
  end

  def products_of_vendor
    @vendor = Vendor.find(params[:supplierid]) if params[:supplierid]
    @products = []
    @products = @vendor.products if @vendor
    if @products.blank?
      render json:{:status => false, :message => "No product found under this Supplier name"}
    end
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find vendor As per given Id  on cloud"}
  end

end
