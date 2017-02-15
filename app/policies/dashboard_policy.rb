class DashboardPolicy < ApplicationPolicy
  policy do
    desc "面板"
    resource "Dashboard"
    permit :read, "查看"
  end

  def index?
    read?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
