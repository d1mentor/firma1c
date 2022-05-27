json.extract! location, :id, :name, :adress, :description, :flag, :photos_url, :created_at, :updated_at
json.url location_url(location, format: :json)
