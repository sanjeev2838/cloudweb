json.set! :status ,true
json.diary do |json|
    json.array!(@diaries) do |diary|
      json.extract! diary, :log
      json.set! "pictures" , get_pictures(diary.pictures)
<<<<<<< HEAD
      json.set! "milestones", get_milestones(diary)
=======
>>>>>>> cbe25eb4d5f369b4d3364495998cf8e61f18c171
      json.set! "datetime", diary.created_at
    end
end
