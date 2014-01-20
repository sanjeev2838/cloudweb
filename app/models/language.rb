class Language < ActiveRecord::Base
   attr_accessible :title

  belongs_to :milestone
end
