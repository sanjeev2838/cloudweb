class Logbook < ActiveRecord::Base
  attr_accessible :log ,:parent_profile_id

  validates :log , :presence => true
  belongs_to :user
  belongs_to :child_profile
  belongs_to :parent_profile
  # for changing the format true and false in apis
  #def as_json(options = { })
  #  h = super(options)
  #  h["status"]   = true
  #  h
  #end
end
