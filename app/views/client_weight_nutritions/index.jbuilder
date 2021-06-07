json.success "success"
json.data do
  json.client_weight_nutritions @records
end

json.limit @limit
json.page @page
json.count @count
json.total @total