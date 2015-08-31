json.array!(@otdels) do |otdel|
  json.extract! otdel, :id, :name
  json.url otdel_url(otdel, format: :json)
end
