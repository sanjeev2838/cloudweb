class Vaccine < ActiveRecord::Base
  attr_accessible :title,:age,:year_courses,:vaccination_against,:number_of_doses ,:status,:locale ,:count,:vaccine_ages_attributes
  attr_accessor :count
  LANG = %w(sv no en)

  #validates :title,:presence => true
  #serial_id_regex = /[1-9]\d*(,\d+)?$/
  #validates :age ,format:     { with: serial_id_regex }
  has_many :vaccine_ages, :dependent => :destroy
  accepts_nested_attributes_for :vaccine_ages, :reject_if => lambda { |a| a[:vaccine_ages].blank? }, :allow_destroy => true


end
