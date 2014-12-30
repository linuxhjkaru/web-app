class FacebookInfo < Service

  field :email
  field :url
  field :expires_at
  field :expires, type: Boolean

  def set_auth auth
    info = auth["info"]
    self["rawdata"]    = auth["extra"]["raw_info"]
    self.service_id    = auth["uid"]
    self.screen_name   = info["nickname"]
    self.name          = info["name"]
    self.profile_image = info["image"]
    self.description   = auth["description"]
    self.oauth_token   = auth["credentials"]["token"]
    self.expires_at    = auth["credentials"]["expires_at"]
    self.expires       = auth["credentials"]["expires"]
  end

  #
  # post
  #

  def post message, pictures
    if pictures.length <= 1
      options = {
        :message => message,
        :picture => pictures[0]
      }
      api.put_object("me", "feed", options)
    else
      album_id = api.put_object(
        "me", 'albums', {:name => 'Homeup', :description => message}, {})['id']
      pictures.each do |picture|
        api.put_picture(picture, {:message => message} , album_id)
      end
    end
  end

  def deauthorize
    api.delete_connections("me", "permissions")
    return self.delete
  end

  #
  # api
  #
  def api
    unless @api
      @api = Koala::Facebook::API.new(oauth_token)
    end
    @api
  end

  #
  # url
  #
  def url

  end
end
