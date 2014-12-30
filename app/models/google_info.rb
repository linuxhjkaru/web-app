class GoogleInfo < Service

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
    self.email         = info["email"]
    self.url           = info["urls"]["Google"]
    self.description   = auth["description"]
    self.oauth_token   = auth["credentials"]["token"]
    self.expires_at    = auth["credentials"]["expires_at"]
    self.expires       = auth["credentials"]["expires"]
  end

  #
  # post
  #
  def post(opt)
    opt = if opt.is_a? Hash
            [opt.delete(:message), opt]
          else
            [opt]
          end
    api.update(*opt)
  end

  #
  # api
  #
  def api
    unless @api
    end
    begin
      @api
    end
  end

  #
  # url
  #
  def url

  end
end
