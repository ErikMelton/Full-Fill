class DashboardController < ApplicationController
  def index
    @person = Person.first
    flash[:success] = "Welcome to the Dashboard!"
    end
end
