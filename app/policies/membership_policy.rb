class MembershipPolicy < ApplicationPolicy
  def destroy?
    record.pool.memberships.where(role: 1, user: user).any? || record.pool.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
