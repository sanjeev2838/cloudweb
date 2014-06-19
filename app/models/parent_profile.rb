class ParentProfile < ActiveRecord::Base
  attr_accessible :devicetypeid, :tokenid, :status, :name, :is_machine_owner,
                  :serialid, :authtoken, :email, :password, :relation, :lang

  attr_accessor   :serialid
  validates :serialid ,:numericality => true
  #has_many :child_parent_relationships
  #has_many :child_profiles ,:through => :child_parent_relationships
  has_many :child_profiles
  has_many :logbooks
  belongs_to :machine

  before_save :check_machine_serial_id
  before_create :generate_access_token
  validates :devicetypeid,:serialid,:name,:email,:password, :relation, :presence => true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  #validates :tokenid, :uniqueness => true ,:message=>"Device already registered"

  RELATIONS = {  mamma: 0, pappa: 1, gaurdian: 2 }
  DEVICES = { iphone: 0 , android: 1 , blackberry: 2}
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
        @machine.update_attributes(:status=>true)
      else
        self.is_machine_owner = true
        @machine.update_attributes(:status=>true)
      end
    end
  end

  def serialid
    if self.machine_id
      @machine = Machine.find(self.machine_id)
      @machine.serialid
    end
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self,"profile").deliver
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

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def generate_access_token
      self.authtoken = SecureRandom.hex
  end

end
