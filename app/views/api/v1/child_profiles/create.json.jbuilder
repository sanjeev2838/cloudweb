json.set! :status ,true
json.set! :status_code , 4006
json.set! :message ,"child profile created/updated successfully"
json.set! :id , @child_profile.id
json.set! :preference_id, child_profile.preference_id
json.brewingpreference do |json|
  json.set! :milk,child_profile.child_brewing_preference.milk
  json.set! :temperature,child_profile.child_brewing_preference.temperature
end
json.set! :filepath, request.protocol + request.host_with_port + @picture.image_url  unless @picture.nil?
