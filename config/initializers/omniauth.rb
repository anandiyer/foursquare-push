Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :foursquare, '6163584490d26781ed32f89afeb4df7304a6e596d', '112bcac179aed01794d728c3c945b9c8'  
end