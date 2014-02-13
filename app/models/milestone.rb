class Milestone < ActiveRecord::Base
  attr_accessible :title,:image,:lang

  #has_many :languages
  has_one :picture
  validates :title,:image ,:presence => true

  mount_uploader :image, ImageUploader

  translates :title
end
