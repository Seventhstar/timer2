json.array!(@ut_types) do |ut_type|
  json.extract! ut_type, :id, :name
  json.url ut_type_url(ut_type, format: :json)
end
