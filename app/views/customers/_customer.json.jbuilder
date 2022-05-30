json.extract! customer, :id, :name, :position, :company, :description, :phone, :email, :created_at, :updated_at
json.url customer_url(customer, format: :json)
