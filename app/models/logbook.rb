class Logbook < ActiveRecord::Base
  attr_accessible :description

  belongs_to :user
  belongs_to :parent_profile
end
