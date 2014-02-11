User.create!(:name=>"admin",:email=>"admin@email.com",:password=>"password",:password_confirmation=>"password",:admin=>true)

@machine=Machine.create!(:bootloader=>312,:firmware=>331,:hwconfig=>1231,:ipaddress=>'diluo.impingeonline.com',:macaddress=>'00:09:6B:fF:FE:42',:serialid=>12,:status=>true)
 if @machine
    @parent_profile = ParentProfile.create!(:devicetypeid=>0,:tokenid=>"r32r32",:serialid=>@machine.serialid,:name=>"rahul",:email=>"user@email.com",:password=>"password",:relation=>0,:lang=>"en",:status=>true)
    @child_profile = @parent_profile.child_profiles.create!(:name=>"Child1",:dob=>"2013-12-12",:gender => "male")
 end

10.times do |vac|
  Vaccine.create!(:title=>"vac#{vac}")
end

