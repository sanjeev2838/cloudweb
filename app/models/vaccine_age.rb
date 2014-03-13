class VaccineAge < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :vaccine
end
