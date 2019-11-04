class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  delegate :name, to: :user, prefix: :user
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.max_content}
  validates :image, content_type: {in: Settings.content_type,
                                   message: I18n.t("must_be_valid_format")},
                    size: {less_than: Settings.max_file_size.megabytes,
                           message: I18n.t("should_be_less_than_5MB")}

  scope :order_by_created_at, ->{order created_at: :desc}

  def display_image
    image.variant resize_to_limit: Settings.limit_image
  end
end
