class Vaccine < ActiveRecord::Base
  attr_accessible :title,:age,:year_courses,:vaccination_against,:number_of_doses ,:status,:locale

  belongs_to :child_stat

  translates :title,:age,:year_courses,:vaccination_against,:number_of_doses

end
