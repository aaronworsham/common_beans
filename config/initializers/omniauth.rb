Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, 'jJCiEwsWy1IGnF10dLesrQ', 'OBOfZXQBy3dcuDtiF03qdwW8PVEFyl6UCghyy9ltgc'
  provider :facebook, '156952871058260', '0f2ea013967c1d7d7f17de80909d4184'
  provider :google, '1062763588590.apps.googleusercontent.com', 'Wj3iQEJJOz75jTE2tkQZUVna'
end 

