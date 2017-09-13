json.payload do
  json.properties @properties, :id, :address, :city, :state, :zip, :status, :notes
  json.count @properties.count
end