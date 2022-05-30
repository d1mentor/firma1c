json.extract! payment, :id, :date, :size, :description, :created_at, :updated_at
json.url payment_url(payment, format: :json)
