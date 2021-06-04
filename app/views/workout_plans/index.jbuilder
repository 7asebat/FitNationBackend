json.status "success"
json.data do
  json.workout_plans @workout_plans.decorate.as_json
end