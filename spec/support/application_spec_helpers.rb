def login(user)
  case user.provider
  when 'twitter'  then visit '/auth/twitter'
  when 'facebook' then visit '/auth/facebook'
  when 'google'   then visit '/auth/google'
  end
end