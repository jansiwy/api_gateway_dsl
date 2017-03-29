POST '/pets' do
  header 'Accept-Language'

  LAMBDA 'arn:aws:lambda:eu-west-1:123456789012:function:create_pet'

  RESPONSE 201 do
    header 'Location', integration: { response: { body: 'location' } }
  end

  RESPONSE 500, /\n|.*/
end
