class QuestionPolicy < ApplicationPolicy
  def create?
    user.is_admin?(record.pool)
  end
  
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
