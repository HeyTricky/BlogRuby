class User < ActiveRecord::Base
  before_create :create_role

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :users_roles
  has_many :roles, :through => :users_roles
  has_many :posts
  has_many :comments
  before_save {self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false }
  
  def has_role?(role_sym)
    roles.any? {|r| r.name.underscore.to_sym == role_sym }
  end

  private
  def create_role
    self.roles << Role.find_by_name("user")
  end


end
