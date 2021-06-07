json.status:"success"
json.data do
    json.exercise @exercise.decorate.as_json
end
