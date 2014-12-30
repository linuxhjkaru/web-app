# -*- coding: utf-8 -*-
class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongoid::Paperclip

  belongs_to :user

  field :lname
  field :fname
  field :lname_kana
  field :fname_kana
  field :tel
  field :annotation
  field :sex
  field :birthday, type: Date
  field :show_tutorial, default: true

  # field :creditcard, type: Hash

  #
  # 外部サービス
  #
  embeds_many :services do
    %w(twitter facebook google).each do|name|
      eval %Q{
        def #{name}
          criteria.where(_type: '#{name.capitalize}Info').first || build({}, '#{name.capitalize}Info'.constantize)
        end
      }
    end
  end

  # has_mongoid_attached_file :photo,
  #   default_url: "/assets/default_icon.png",
  #   path: ":attachment/:id/:style.:extension",
  #   storage: :s3,
  #   url: ":s3_alias_url",
  #   s3_host_alias: "ed-system.s3.amazonaws.com",
  #   s3_protocol: "https",
  #   s3_credentials: File.join(Rails.root, "config", "aws.yml"),
  #   styles: {
  #     original: ["1920x1680>", :jpeg],
  #     large: ["1024x1024>", :jpeg],
  #     normal: ["600x600>", :jpeg],
  #     thumb: ["120x120#", :jpeg]
  #   },
  #   convert_options: {all: "-background white -flatten +matte"}

  # attr_accessor :delete_photo
  # validates_attachment_content_type :photo,
  #   content_type: %w(image/jpeg image/jpg image/png)

  def full_name
    "#{lname} #{fname}"
  end

  def name
    full_name.blank? ? nil : full_name
  end

end
