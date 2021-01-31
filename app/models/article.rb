class Article < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 30000 }
  validates :title, presence: true, length: { maximum: 32 }
  paginates_per 8
  mount_uploader :image, ImageUploader
end
