class Diary < ActiveRecord::Base
    attr_accessible :log
    belongs_to :child_profile
    has_many :pictures
    has_and_belongs_to_many :milestones
end

