#TODO  change these curl commands with active record creation code (only works when server is running)

# to create an admin user
#User.create!(:email=>'admin@test.com',:username=>'admin',:password=>'password')

#only works when server is running
#to create a new machine
#%x(curl -X POST -H "Content-type: application/json" -d  '{"bootloader":"312","firmware":"331","hwconfig":"1231","ipaddress":"123.10.23.12","macaddress":"00:09:6B:fF:FE:42","serialid":12}' http://localhost:3000/api/v1/hosts )

# to create new parent profile
%x(curl -X POST -H "Content-type: application/json" -d '{"deviceid":231,"devicetypeid":0,"tokenid":"r32r32","serialid":"12","name":"rahul","imei":"123"}' http://localhost:3000/api/v1/profiles  )

# to create a child profile
%x(curl -X POST -H "Content-type: application/json" -d '{"name":"patani","dob":0,"gender":"male","preferences":{"temperature":23,"milk":12}}' http://localhost:3000/api/v1/profiles/1/children )
