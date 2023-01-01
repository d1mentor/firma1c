json.extract! payment_tag, :id, :name, :comment, :created_at, :updated_at
json.url payment_tag_url(payment_tag, format: :json)
