class PoolPolicy < ApplicationPolicy
  def admin?
    record.memberships.where(user: user, role: 1).any? || record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
