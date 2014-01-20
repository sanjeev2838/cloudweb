class ParentProfile < ActiveRecord::Base
  attr_accessible :deviceid, :devicetypeid, :imei, :tokenid, :status, :name, :is_machine_owner,
                  :serialid

  attr_accessor   :serialid

  has_many :child_profiles
  belongs_to :machine
  #has_many :pictures
  #has_many :child_stats
  #has_many :child_brewing_preferences
  has_many :logbooks


  before_save :check_machine_serial_id
  validates :deviceid, :devicetypeid, :tokenid,
            :serialid,:name,:imei, :presence => true

  def as_json(options ={})
    h = super(options)
    h["status"] = true
    h
  end

  def serialid=(machine_serial_id)
    @machine = Machine.where(:serialid =>machine_serial_id).first
    if @machine
      self.machine_id = @machine.id
    # set machine owner
      if ParentProfile.where(:machine_id => @machine.id).first
        self.is_machine_owner = false
      else
        self.is_machine_owner = true
      end
    end
  end



  def serialid
    if self.machine_id
      @machine = Machine.find(self.machine_id)
      @machine.serialid
    end
  end

  def devise_type
    return "Andriod" if self.devicetypeid == 0
    return "Iphone" if self.devicetypeid == 1
    return "Blackberry" if self.devicetypeid == 2
  end

  private
  def check_machine_serial_id
    if self.machine_id.nil?
      errors.add(:machine_serial_id , "please provide valid machine serial_id " )
      false
    else
      true
    end
  end

end
