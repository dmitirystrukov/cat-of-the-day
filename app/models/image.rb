class Image < ActiveRecord::Base
  belongs_to :object, polymorphic: true
  has_attached_file :image, styles: { medium: '350x330>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
