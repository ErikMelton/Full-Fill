class DashboardController < ApplicationController
  def index
    if(!client_signed_in?)
      redirect_to '/'
    end

    @person = Person.find_by(client_id: current_client.id)
    flash[:success] = 'Welcome, ' + @person.name_first + ' to the Dashboard!'
    end
end
