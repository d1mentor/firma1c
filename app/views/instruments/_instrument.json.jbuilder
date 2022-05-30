json.extract! instrument, :id, :name, :description, :location_id, :created_at, :updated_at
json.url instrument_url(instrument, format: :json)
