json.payload do
  json.id @sheet.id
  json.title @sheet.title
  json.year @sheet.year
  json.display @sheet.display
  json.entries @entries do |entry|
  	json.id entry.id
  	json.amount number_to_currency(entry.amount)
  	json.account entry.account
    json.debit entry.debit
  	json.paid entry.paid
  	json.date entry.date
  	json.category_name entry.category_name
    json.address entry.address_string
  end
  json.headers @headers do |header|
    json.name header[:name]
    json.value header[:value]
  end
end