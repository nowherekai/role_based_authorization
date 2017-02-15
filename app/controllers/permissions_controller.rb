class PermissionsController < ApplicationController
  # GET /permissions
  # GET /permissions.json
  def index
    @permissions = ApplicationPolicy.policies
  end

  # GET /permissions/1
  # GET /permissions/1.json
  def show
  end

end
