json.array!(@short_urls) do |short_url|
  json.extract! short_url, :orginal_url, :shorty, :visit_count
  json.url api_v1_short_urls_url(short_url, format: :json)
  json.short_url  "#{request.protocol}#{request.host_with_port}/short/#{short_url.shorty}"
end
