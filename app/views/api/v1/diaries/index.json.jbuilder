json.set! :status ,true
json.diary do |json|
    json.array!(@diaries) do |diary|
      json.extract! diary, :log
      json.set! "pictures" , get_pictures(diary.pictures)
      json.set! "milestones", get_milestones(diary)
      json.set! "datetime", diary.created_at
    end
end
