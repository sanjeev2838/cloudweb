class Profile < ActiveRecord::Base
  attr_accessible :key_32, :key_33, :key_34, :key_35, :key_36, :key_37, :key_38, :key_39, :key_40, :key_41, :key_42,
                  :key_43, :key_44, :key_45, :key_46, :key_47, :key_48, :key_49, :key_50, :volume, :product_id

  validates :key_32, :key_33, :key_34, :key_35, :key_36, :key_37, :key_38, :key_39, :key_40, :key_41, :key_42,
            :key_43, :key_44, :key_45, :key_46, :key_47, :key_48, :key_49, :key_50, :volume,  numericality: true

  belongs_to :product
end
