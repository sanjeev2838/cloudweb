class Vaccine < ActiveRecord::Base
  attr_accessible :title,:status,:en,:sv,:no,:vaccine_ages_attributes
  attr_accessor :count
  LANG = %w(sv no en)

  has_many :vaccine_ages, :dependent => :destroy

  accepts_nested_attributes_for :vaccine_ages ,:allow_destroy => true
 end
