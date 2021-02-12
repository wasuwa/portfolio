class Article < ApplicationRecord
  belongs_to :user
  has_many :favorites, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  default_scope -> { order(:created_at => :desc) }
  validates :user_id, :presence => true
  validates :content, :presence => true, :length => { :maximum => 30000 }
  validates :title, :presence => true, :length => { :maximum => 32 }
  paginates_per 8
  mount_uploader :image, ImageUploader

  # お気に入りに追加されているか
  def favorited_by?(user)
    favorites.where(:user_id => user.id).exists?
  end
end