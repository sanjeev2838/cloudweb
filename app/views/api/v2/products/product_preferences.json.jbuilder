json.set! :status ,true
json.set! :preferences, @preferences
json.preferences do |json|
  json.array!(@preferences) do |preference|
    json.extract! preference, :id, :water, :brew_type,:temperature,:quantity
  end
end