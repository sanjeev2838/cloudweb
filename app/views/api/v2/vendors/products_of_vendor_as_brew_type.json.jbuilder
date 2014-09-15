json.set! :status ,true

json.products do |json|
  json.array!(@products) do |product|
    json.extract! product, :id
    json.set! "productname", product.name
  end
end