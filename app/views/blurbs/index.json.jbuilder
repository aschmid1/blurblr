json.array!(@blurbs) do |blurb|
  json.extract! blurb, :id, :user_id, :content
  json.url blurb_url(blurb, format: :json)
end
