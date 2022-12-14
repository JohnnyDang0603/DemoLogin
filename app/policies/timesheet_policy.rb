class TimesheetPolicy < ApplicationPolicy
  def edit?
    manage?
  end

  def update?
    manage?
  end

  def new?
    # manage?
  end

  def create?
    # manage?
  end

  def index?
    manage?
  end

  private

  def manage?
    user.admin?
  end
end
