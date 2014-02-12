json.set! :status ,true
json.set! :status_code, 3000
json.set! :message ,"Parent profile created successfully"
json.extract! @parent_profile ,  :id  , :authtoken