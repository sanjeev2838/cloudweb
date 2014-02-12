class ChildParentRelationship < ActiveRecord::Base
  belongs_to :child_profile
  belongs_to :parent_profile
  # attr_accessible :title, :body
end
