OPTIONS '/pets' do
  MOCK 200

  RESPONSE 200 do
    header 'Access-Control-Allow-Headers', 'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'
    header 'Access-Control-Allow-Methods', 'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'
    header 'Access-Control-Allow-Origin',  '*'
  end
end
