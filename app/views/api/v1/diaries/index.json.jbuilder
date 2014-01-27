json.set! :status ,true
json.diary do |json|
    json.array!(@diaries) do |diary|
      json.extract! log_book, :diary
      json.set! "datetime", log_book.created_at
    end
end
