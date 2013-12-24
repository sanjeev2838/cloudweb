class ChildStat < ActiveRecord::Base
  attr_accessible :diaper_count, :food, :height, :weight

  belongs_to :child_profile
  has_many :vaccines
  belongs_to :parent_profile
end
