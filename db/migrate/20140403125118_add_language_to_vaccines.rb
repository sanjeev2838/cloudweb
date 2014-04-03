class AddLanguageToVaccines < ActiveRecord::Migration
  def change
    add_column :vaccines, :en, :string
    add_column :vaccines, :sv, :string
    add_column :vaccines, :no, :string
  end
end
