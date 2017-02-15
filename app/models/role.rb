class Role < ApplicationRecord
  has_many :permissions

  def permission_values
    permissions.map(&:action_resource)
  end

  def permission_values=(action_resources)
    add = action_resources - permission_values
    delete = permission_values - action_resources

    delete.each do |action_resource|
      action, resource = action_resource.split("#", 2)
      permissions.select do |permission|
        permission.action == action && permission.resource == resource
      end.each(&:mark_for_destruction)
    end
    add.each do |action_resource|
      action, resource = action_resource.split("#", 2)
      permissions.build action: action, resource: resource
    end
  end
end
