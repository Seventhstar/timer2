json.array!(@goals) do |goal|
  json.extract! goal, :id, :name, :description, :user_id, :fixed, :personal, :start_date
  json.url goal_url(goal, format: :json)
end
