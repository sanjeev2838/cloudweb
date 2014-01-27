json.set! :status ,true
json.milestones do |json|
    json.array!(@milestones) do |milestone|
      json.extract! milestone, :id, :title
      json.set! "icon",  milestone.image_url
    end
end
