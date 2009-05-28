module Watchman
  class Error < RuntimeError
  end
  class NoUserError < Error
  end
  class UnauthorizedError < Error
    attr_accessor :permission, :scope
    def initialize(permission, scope)
      @permission=permission
      @scope=scope
    end
  end
end
