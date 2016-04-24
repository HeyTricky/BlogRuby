class Comment < ActiveRecord::Base
 # include Authority::Abilities
  belongs_to :post
  belongs_to :user
  validates :body, presence: true, length: { maximum: 200 }

 # self.authorizer_name = 'AdminAuthorizer'
end
