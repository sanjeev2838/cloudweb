json.set! :status ,true
json.picture do
    json.pictureid  @picture.id
    json.filepath  @picture.image.path
    json.profilepic @picture.profilepic
end
