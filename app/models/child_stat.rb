class ChildStat < ActiveRecord::Base
  attr_accessible :diapers, :meals, :height, :weight ,:bottle ,:vaccine_id

  belongs_to :child_profile
  has_many :vaccines
  belongs_to :parent_profile
end
