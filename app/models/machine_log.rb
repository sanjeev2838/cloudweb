class MachineLog < ActiveRecord::Base
  attr_accessible :description

  belongs_to :machine
end
