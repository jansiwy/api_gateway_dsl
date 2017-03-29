ANY '/pets/{proxy+}' do
  path   'proxy'
  header 'Accept-Language'

  HTTP_PROXY_ANY 'https://petstore.example.com/{proxy}' do
    path   'proxy'
    header 'Accept-Language'
  end
end
