json.counts do
  json.exercises @exercises_count.to_i
  json.workout_plans @workout_plans_count.to_i
  json.trainers @trainers_count.to_i
  json.clients @clients_count.to_i
  json.food @food_count.to_i
  json.exercises_types @exercises_types_count
end
