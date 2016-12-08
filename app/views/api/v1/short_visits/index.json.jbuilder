json.array!(@short_visits) do |short_visit|
  json.extract! short_visit, :visitor_ip, :visitor_city, :visitor_state, :visitor_country, :visitor_country_iso
  json.url api_v1_short_visits_path(short_visit, format: :json)
end
