class VaccineLanguage < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :vaccine
end
