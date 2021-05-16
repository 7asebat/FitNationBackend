json.status "success"
json.data do
  json.user @user.decorate.as_json
end