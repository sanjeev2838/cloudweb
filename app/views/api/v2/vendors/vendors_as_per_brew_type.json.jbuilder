json.set! :status ,true
json.set! :suppliers, @vendors

json.suppliers do |json|
  json.array!(@vendors) do |vendor|
    json.extract! vendor, :id
    json.set! "suppliername", vendor.name
  end
end