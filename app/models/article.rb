class Article < ApplicationRecord
  belongs_to :user
  has_many :favorites
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 30000 }
  validates :title, presence: true, length: { maximum: 32 }
  paginates_per 8
  mount_uploader :image, ImageUploader

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end