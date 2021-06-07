json.success "success"
json.data do
  json.food @records
end

json.limit @limit
json.page @page
json.count @count
json.total @total