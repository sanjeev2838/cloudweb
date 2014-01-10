class Logbook < ActiveRecord::Base
  attr_accessible :log

  validates :log , :presence => true
  belongs_to :user
  belongs_to :child_profile

  # for changing the format true and false in apis
  #def as_json(options = { })
  #  h = super(options)
  #  h["status"]   = true
  #  h
  #end
end
