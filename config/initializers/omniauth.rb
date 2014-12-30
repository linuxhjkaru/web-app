Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, Settings.twitter.key, Settings.twitter.secret,
  # {
  #   :secure_image_url => 'true',
  #   :image_size => 'original',
  #   :authorize_params => {
  #     :lang => 'ja'
  #   }
  # }
  # provider :facebook, Settings.facebook.key, Settings.facebook.secret,
  # {
  #   locale: "ja",
  #   secure_image_url: true,
  #   scope: "email,user_photos,publish_actions,read_stream,read_insights"
  # }
  provider :google_oauth2, Settings.youtube.key, Settings.youtube.secret,
  {
    :name => "google",
    :scope => "email, profile, plus.me, http://gdata.youtube.com",
    :prompt => "select_account",
    :image_aspect_ratio => "square",
    :image_size => 50
  }
end
