class AddBrewTypeToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :brew_type, :string
  end
end
