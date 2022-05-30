json.extract! diary, :id, :person_id, :work_id, :completed_work_size, :date, :description, :created_at, :updated_at
json.url diary_url(diary, format: :json)
