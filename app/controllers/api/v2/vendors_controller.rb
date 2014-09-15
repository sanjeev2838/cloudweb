class Api::V2::VendorsController < Api::Default::BaseController

  def vendors_as_brew_type
    @vendors = Vendor.joins(:products).where("products.brew_type = ?",params[:brew_type]).uniq
    if @vendors.blank?
      render json:{:status => false, :message => "Unable to find any Supplier with given Brew type"}
    end
  end

  def products_of_vendor_as_brew_type
    @vendor = Vendor.find(params[:supplierid]) if params[:supplierid]
    @products = []
    if params[:brew_type]
      @products = @vendor.products.where('products.brew_type = ?', params[:brew_type])
    else
      render json:{:status => false, :message => "Please specify Brew type as Query parameter"}
    end

    if @products.blank?
      render json:{:status => false, :message => "No product found under this Supplier name and brew type"}
    end
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find vendor As per given Id  on cloud"}
  end

end
