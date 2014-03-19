class Milestone < ActiveRecord::Base
  attr_accessible :title,:image,:lang ,:en,:sv,:no

  belongs_to :diary
  has_one :picture
  validates :title,:image ,:presence => true

  mount_uploader :image, ImageUploader

  LANG = %w(sv no en)




end
