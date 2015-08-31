json.array!(@used_times) do |used_time|
  json.extract! used_time, :id, :otdel_id, :seconds, :user_id, :ut_type_id, :task_id
  json.url used_time_url(used_time, format: :json)
end
