json.extract! @posts

json.response do
  json.status  'success'
  json.message 'OK'
  json.data do
  json.array!(@posts) do |post|
    json.image post.image.url
    json.title post.title
    json.body post.body
  end
  end
end
