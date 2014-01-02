class ParentProfile < ActiveRecord::Base
  attr_accessible :device_id, :device_type_id, :imei, :token_id, :status, :name, :is_machine_owner,
                  :machine_serial_id
  attr_accessor   :machine_serial_id
  ##belongs_to :machine
  has_many :child_profiles
  #has_many :pictures
  #has_many :child_stats
  #has_many :child_brewing_preferences

  belongs_to :machine

  def machine_serial_id=(serial_id)
    @machine = Machine.where(:serial_number =>serial_id).first
    self.machine_id = @machine.id
  end

  def machine_serial_id
    if self.machine_id
      @machine = Machine.find(self.machine_id)
      @machine.serial_number
    end
  end

end
