class ChildBrewingPreferencesController < ApplicationController
  before_filter :find_vendor

  def show
    @product = Product.find(params[:product_id])
    @child_brewing_preference = ChildBrewingPreference.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @child_brewing_preference }
    end
  end

  def new
    @product = Product.find(params[:product_id])
    respond_to do |format|
      if @product.child_brewing_preferences.count >= 3
       format.html { redirect_to  vendor_product_path(@vendor,@product),:alert => "You have already added three preference for each brew type"  }
      else
       child_brewing_preference = @product.child_brewing_preferences.new
       format.html
       format.json { render json: @child_brewing_preference }
      end
    end
  end

  def edit
    @product = Product.find(params[:product_id])
    @child_brewing_preference = ChildBrewingPreference.find(params[:id])
  end

  # child_brewing_prefernces is also used to save settings for product
  def create
    @product = Product.find(params[:child_brewing_preference][:product_id])
    @old_product_preference = @product.child_brewing_preferences.where("brew_type = ? and product_id = ? ", params[:child_brewing_preference][:brew_type], params[:child_brewing_preference][:product_id] ).first
    @new_product_preference = @product.child_brewing_preferences.new(params[:child_brewing_preference])

    respond_to do |format|
      if @old_product_preference.nil?
        if @new_product_preference.save
          format.html { redirect_to  vendor_product_path(@vendor,@product), notice: 'Child brewing preference was successfully created.' }
          format.json { render json: @new_product_preference, status: :created, location: @new_product_preference }
        else
          format.html { render action: "new" }
          format.json { render json: @new_product_preference.errors, status: :unprocessable_entity }
        end
      else
        flash.now[:alert] = "Please select diffrent brew type to save settings for product"
        # work around to make child_brew_preference form workable
        @child_brewing_preference = @new_product_preference
        format.html { render action: "new" }
        format.json { render json: @new_product_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:child_brewing_preference][:product_id])
    @old_product_preference = @product.child_brewing_preferences.where("brew_type = ? and product_id = ? ", params[:child_brewing_preference][:brew_type], params[:child_brewing_preference][:product_id] ).first
    @child_brewing_preference = ChildBrewingPreference.find(params[:id])

    respond_to do |format|
      if @old_product_preference.nil?
        if @child_brewing_preference.update_attributes(params[:child_brewing_preference])
          format.html { redirect_to vendor_product_path(@vendor,@product), notice: 'Child brewing preference was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @child_brewing_preference.errors, status: :unprocessable_entity }
        end
      else
        flash.now[:alert] = "There is already a product preferences with this brew type"
        format.html { render action: "edit" }
        format.json { render json: @child_brewing_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @child_brewing_preference = ChildBrewingPreference.find(params[:id])
    @child_brewing_preference.destroy

    respond_to do |format|
      format.html { redirect_to vendor_product_path(@vendor,@product) }
      format.json { head :no_content }
    end
  end


  private
  def find_vendor
    @vendor =  Vendor.find(params[:vendor_id])
  end
end
