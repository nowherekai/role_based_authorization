class Permission < ApplicationRecord
  belongs_to :role

  def action_resource
    "#{action}##{resource}"
  end
end
