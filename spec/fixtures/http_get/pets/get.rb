GET '/pets' do
  query  'q'
  header 'Accept-Language'

  HTTP_GET 'https://petstore.example.com' do
    query  'q'
    header 'Accept-Language'
  end

  RESPONSE 200, /^200$/ do
    header 'Content-Language'
  end

  RESPONSE 500
end
