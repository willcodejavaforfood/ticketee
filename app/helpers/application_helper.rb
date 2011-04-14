module ApplicationHelper
  def admins_only(&block)
    block.call if current_user && current_user.admin?
    nil
  end
end
