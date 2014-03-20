class Milestone < ActiveRecord::Base
  attr_accessible :title,:image,:lang ,:en,:sv,:no

  has_and_belongs_to_many :diaries
  has_one :picture
  validates :title,:image ,:presence => true

  mount_uploader :image, ImageUploader

  LANG = %w(sv no en)




end
