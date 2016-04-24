# Other authorizers should subclass this one
class ApplicationAuthorizer < Authority::Authorizer

  # Any class method from Authority::Authorizer that isn't overridden
  # will call its authorizer's default method.
  #
  # @param [Symbol] adjective; example: `:creatable`
  # @param [Object] user - whatever represents the current user in your app
  # @return [Boolean]
  def self.default(able, user)
    # 'Whitelist' strategy for security: anything not explicitly allowed is
    # considered forbidden.
    has_role_granting?(user,able) || user.admin?
  end

  protected

  def has_role_granting(user,able)
    (roles_which_grant(able) & user.roles).any?
  end

end
