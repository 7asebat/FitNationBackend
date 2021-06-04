json.success "success"
json.data do
  json.user @user.decorate.as_json
  json.token @token
end