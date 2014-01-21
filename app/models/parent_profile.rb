class ParentProfile < ActiveRecord::Base
  attr_accessible :devicetypeid, :tokenid, :status, :name, :is_machine_owner,
                  :serialid, :authtoken, :email, :password, :relation, :lang

  attr_accessor   :serialid

  has_many :child_profiles
  has_many :logbooks
  belongs_to :machine

  before_save :check_machine_serial_id
  before_create :generate_access_token
  validates :devicetypeid, :tokenid,
            :serialid,:name,:email,:password, :relation, :presence => true

  RELATIONS = {  mamma: 0, pappa: 1, gaurdian: 2 }
  DEVICES = { andriod: 0 , iphone: 1 , blackberry: 2}
  LANG = %w(sv no en)
  validates :relation, inclusion: {in: ParentProfile::RELATIONS.values}
  validates :devicetypeid, inclusion: {in: ParentProfile::DEVICES.values}
  validates :lang, inclusion: {in: ParentProfile::LANG }

  def relation_type
    ParentProfile::RELATIONS.key(self.relation).to_s
  end


  def devise_type
    ParentProfile::DEVICES.key(self.devicetypeid).to_s
  end

  def serialid=(machine_serial_id)
    @machine = Machine.where(:serialid => machine_serial_id).first
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



  private
  def check_machine_serial_id
    if self.machine_id.nil?
      errors.add(:machine_serial_id , "please provide valid machine serial_id " )
      false
    else
      true
    end
  end

  def generate_access_token
      self.authtoken = SecureRandom.hex
  end

end
