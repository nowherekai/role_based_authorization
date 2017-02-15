class UserPolicy < ApplicationPolicy
  policy do
    desc "仪表板"
    permit :read, "查看"
    permit :update, "修改"
  end

  def index?
    read?
  end

  def show?
    read?
  end

  def update?
    super
  end

  def edit
    update?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

end
