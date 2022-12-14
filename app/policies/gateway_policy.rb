class GatewayPolicy < ApplicationPolicy
  def admin_space?
    user.present? && user.admin?
  end
end
