# -*- coding: utf-8 -*-
class Service
  include Mongoid::Document
  include Mongoid::Timestamps

  field :service_id
  field :screen_name
  field :name
  field :profile_image
  field :description
  field :oauth_token
  field :oauth_secret

  embedded_in :profile, :inverse_of => :services

  #
  # profileページのURL
  #
  def url
  end


  #
  # サービスに投稿する
  #
  def post message
  end

end
