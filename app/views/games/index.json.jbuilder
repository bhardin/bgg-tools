json.array!(@games) do |game|
  json.extract! game, :string
  json.url game_url(game, format: :json)
end
