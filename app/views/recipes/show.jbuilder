json.status "success"
json.data do
  json.recipe @recipe.decorate.as_json
end