

@machine=Machine.create!(:bootloader=>312,:firmware=>331,:hwconfig=>1231,:ipaddress=>'123.10.23.12',:macaddress=>'00:09:6B:fF:FE:42',:serialid=>12)
 if @machine
    @parent_profile = ParentProfile.create!(:devicetypeid=>0,:tokenid=>"r32r32",:serialid=>@machine.serialid,:name=>"rahul",:email=>"user@email.com",:password=>"password",:relation=>0,:lang=>"en",:status=>true)
    @child_profile = @parent_profile.child_profiles.create!(:name=>"Child1",:dob=>"2013-12-12",:gender => "male")
 end

