class DashboardController < ApplicationController
  def index
    authorize :dashboard
  end
end
