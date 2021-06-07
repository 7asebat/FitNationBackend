json.status "success"
json.data do
  json.food @food.decorate.as_json
end