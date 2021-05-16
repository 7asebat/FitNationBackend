json.status "success"
json.data do
  json.workout_plan @workout_plan.decorate.as_json
end