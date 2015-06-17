json.array!(@scratchpads) do |scratchpad|
  json.extract! scratchpad, :id, :title, :description
  json.url scratchpad_url(scratchpad, format: :json)
end
