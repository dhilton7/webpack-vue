json.payload do
  json.id @entry.id
  json.id @entry.id
  json.amount number_to_currency(@entry.amount)
  json.account @entry.account
  json.debit @entry.debit
  json.paid @entry.paid
  json.date @entry.date
  json.category_name @entry.category_name
  json.address @entry.address_string
  json.created_at @entry.created_at.strftime('%D')
end