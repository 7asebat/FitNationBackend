json.status "success"
json.data do
  json.user @user_auth.fetch_user.decorate.as_json
  json.token @token
end