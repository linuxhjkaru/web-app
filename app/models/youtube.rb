class Youtube
  include Mongoid::Document
  include Mongoid::Timestamps

  field :owner, type: Time
  field :description,    type: Time
  field :title, type: String
  field :youtube_id,    type: String
  field :duration, type: String

  belongs_to :user

end
