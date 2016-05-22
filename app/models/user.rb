class User < ActiveRecord::Base
  before_create :create_role

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :posts
  has_many :comments
  before_save {self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false }
  
  def has_role?(role_sym)
    return self.role == Role.find_by_name(role_sym.to_sym)
  end

  def set_moderator
    self.role = Role.find_by_name("moderator")
  end

  def set_user
    self.role = Role.find_by_name("user")
  end

  def isModerator?
    return self.role==Role.find_by_name("moderator")
  end

  def isUser?
    return self.role==Role.find_by_name("user")
  end

    def isAdmin?
    return self.role==Role.find_by_name("admin")
  end

  def isMyProfile?(current_user)
    return self.id==current_user.id
  end

  private
  def create_role
    self.role ||= Role.find_by_name("user")
  end


end
