json.set! :status ,true
json.child do |json|
    json.array!(@pictures) do |picture|
         json.pictureid  picture.id
         json.filepath   picture.image.path
    end
end