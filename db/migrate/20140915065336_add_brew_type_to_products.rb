class AddBrewTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :brew_type, :string
  end
end
