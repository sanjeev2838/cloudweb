json.set! :status ,true
json.children do |json|
    json.array!(@child_profiles) do |child_profile|
       json.set! :id,child_profile.id
       json.set! :name,child_profile.name
       json.set! :dob,child_profile.dob
       json.set! :gender,child_profile.gender
       json.set! :filepath, request.protocol + request.host_with_port + child_profile.pictures.first.image_url

    end
end
