json.array!(@monsters) do |monster|
  json.extract! monster, :id, :name, :power, :monster_type, :user_id
  json.url monster_url(monster, format: :json)
end
