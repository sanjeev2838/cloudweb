json.set! :status ,true
json.logs do |json|
    json.array!(@log_books) do |log_book|
      json.extract! log_book, :log
      json.set! "datetime", log_book.created_at
    end
end
