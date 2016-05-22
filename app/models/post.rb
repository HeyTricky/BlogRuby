class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :user_id, presence: true
	validates :title, presence: true, length: { minimum: 5 }
	default_scope -> { order('created_at DESC') }
end
