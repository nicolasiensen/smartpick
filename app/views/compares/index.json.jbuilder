json.array!(@compares) do |compare|
  json.extract! compare, 
  json.url compare_url(compare, format: :json)
end
