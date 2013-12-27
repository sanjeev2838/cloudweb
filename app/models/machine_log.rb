class MachineLog < ActiveRecord::Base
  attr_accessible :description , :machine_id

  belongs_to :machine
end
