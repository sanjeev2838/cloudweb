json.set! :status ,true
json.set! :id , @child_profile.id
json.set! :preference_id , @child_profile.preference_id
json.set! :filepath, request.protocol + request.host_with_port + @picture.image_url