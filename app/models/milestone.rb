class Milestone < ActiveRecord::Base
  attr_accessible :en, :image, :no, :sv, :title
  has_and_belongs_to_many :diaries
  has_one :picture
  validates :title,:image ,:presence => true
  mount_uploader :image, ImageUploader

end
