class MachineLog < ActiveRecord::Base
  attr_accessible :data , :machine_id

  belongs_to :machine

  validates :data, :machine_id ,:presence => true

  def self.android_notifications(token_id,notification)
    GCM.host = 'https://android.googleapis.com/gcm/send'
    GCM.format = :json
    GCM.key="AIzaSyDrBoXTooX3qVrxtIwKijMbH57LFN-weLY"
    data= {:message => notification}
    #destination = "APA91bE4oiEN3727ATzjk56vwdc9E1PHW0Xb-MFSdna__1x5qKnBVWj36GZZTY4haPLwmxui7_9AeJKoKrcKOETgA2vs5tzzg3LjPe4r8uFbSK3YDE_NUirVqN3TgO-OjxN_ncnQTklJShri9WgOB0_EsjAurY9UXA"
    destination = token_id
    puts GCM.send_notification(destination, data)
  end

  def self.iphone_notifications(token_id,notification)
    APNS.host = 'gateway.push.apple.com'
    # gateway.sandbox.push.apple.com is default

    APNS.port = 2195
    # this is also the default. Shouldn't ever have to set this, but just in case Apple goes crazy, you can.

    APNS.pem  = '/path/to/pem/file'
    # this is the file you just created

    #APNS.pass = ''
    # Just in case your pem need a password
    data= {:message => notification}

    destination = token_id
    APNS.send_notification(destination, data )
    #APNS.send_notification(device_token, :alert => 'Hello iPhone!', :badge => 1, :sound => 'default')
  end
end
