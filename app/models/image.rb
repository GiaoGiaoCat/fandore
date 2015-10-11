class Image < ActiveRecord::Base
  belongs_to :viewable, polymorphic: true
  mount_uploader :picture, PhotoUploader

  before_save :init_position

  default_scope -> { order(:position) }

  def self.default_image
    where(viewable_id: nil, viewable_type: nil).first
  end

  private

  def init_position
    self.position = (viewable && viewable.product.max_variants_images_position || 0) + 1
  end

end
