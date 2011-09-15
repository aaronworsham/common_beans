class Provider
  def initialize(auth)
    @auth = auth
  end

  def source
    @auth['provider']
  end

  def uid

    @auth['uid']

  end

  def name
    @auth['user_info']['name']
  end

  def screen_name
    case source
    when 'twitter'
      @auth['user_info']['nickname']
    when 'facebook'
      @auth['user_info']['nickname'].gsub('.','_')
    end
    
  end

  def image_url

    @auth['user_info']['image']
  end
  def location

    @auth['user_info']['location']
  end
  def description

    @auth['user_info']['description']
  end
  def urls

    @auth['user_info']['urls']
  end


end
