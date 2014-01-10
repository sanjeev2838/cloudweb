json.set! :status ,true
json.child do |json|
    json.array!(@pictures) do |picture|
        json.extract! picture, :id
    end
end