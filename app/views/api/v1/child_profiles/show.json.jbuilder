json.set! :status ,true
json.child do
     json.set! :id, @child_profile.id
     json.set! :name, @child_profile.name
     json.set! :dob, @child_profile.dob
     json.set! :gender, @child_profile.gender
     json.set! :filepath, request.protocol + request.host_with_port + @picture.image_url

end