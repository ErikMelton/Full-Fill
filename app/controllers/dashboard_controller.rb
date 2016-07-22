class DashboardController < ApplicationController
  def index
    if(!client_signed_in?)
      redirect_to '/'
    end

    @person = Person.first
    flash[:success] = "Welcome to the Dashboard!"
    end
end
