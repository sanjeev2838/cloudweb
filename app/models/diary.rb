class Diary < ActiveRecord::Base
  attr_accessible :diary, :child_profile_id

  validates :log , :presence => true

  belongs_to :child_profile
  has_many :pictures
end
