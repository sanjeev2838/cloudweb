class Vaccine < ActiveRecord::Base
  attr_accessible :title,:age,:year_courses,:vaccination_against,:number_of_doses ,:status,:locale ,:count,:vaccine_ages_attributes,:vaccine_languages_attributes
  attr_accessor :count
  LANG = %w(sv no en)

  has_many :vaccine_ages, :dependent => :destroy
  has_many :vaccine_languages,:dependent => :destroy
  accepts_nested_attributes_for :vaccine_ages ,:reject_if => lambda{ |a| a[:title].blank?},:allow_destroy => true
  accepts_nested_attributes_for :vaccine_languages  ,:reject_if => lambda{ |a| a[:title].blank?},:allow_destroy => true
end
