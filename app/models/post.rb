class Post < ActiveRecord::Base
  include Authority::Abilities
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }

  self.authorizer_name = 'AdminAuthorizer'
  
end
