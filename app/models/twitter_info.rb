require 'open-uri'

OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
OpenURI::Buffer.const_set 'StringMax', 0

class TwitterInfo < Service

  def set_auth auth
    info = auth["extra"]["raw_info"]
    self["rawdata"]    = info
    self.service_id    = info["id"]
    self.screen_name   = info["screen_name"]
    self.name          = info["name"]
    self.profile_image = info["profile_image_url_https"]
    self.description   = auth["description"]
    self.oauth_token   = auth["credentials"]["token"]
    self.oauth_secret  = auth["credentials"]["secret"]
  end

  #
  # post
  #

  def post tweet, images
    return unless tweet.present?
    media_ids = Array.new
    images.each do |image|
      open(image) do |media|
        media_id = api.upload(media)
        media_ids << media_id
      end
    end
    if media_ids.present?
      api.update(tweet, :media_ids => media_ids.join(","))
    else
      api.update(tweet)
    end
  end

  def deauthorize
    return self.delete
  end

  #
  # api
  #
  def api
    unless @api
      @api = Twitter::REST::Client.new do |config|
        config.consumer_key        = Settings.twitter.key
        config.consumer_secret     = Settings.twitter.secret
        config.access_token        = oauth_token
        config.access_token_secret = oauth_secret
      end
    end
    @api
  end

  #
  # url
  #
  def url
    "http://twitter.com/#{screen_name}"
  end
end
