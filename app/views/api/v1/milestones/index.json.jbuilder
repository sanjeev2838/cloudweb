json.set! :status ,true
json.milestones do |json|
    json.array!(@milestones) do |milestone|
      json.extract! milestone, :id
      json.set! "milestone", milestone.title
      json.set! "icon", request.protocol + request.host_with_port + milestone.image_url
    end
end
