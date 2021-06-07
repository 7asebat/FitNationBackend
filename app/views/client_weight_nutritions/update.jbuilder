json.status:"success"
json.data do
    json.client_weight_nutritions @client_w_n.decorate.as_json
end