class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :body, presence: true, length: { maximum: 120 }
  default_scope -> { order('created_at DESC') }
end
