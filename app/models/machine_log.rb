class MachineLog < ActiveRecord::Base
  attr_accessible :data , :machine_id

  belongs_to :machine
end
