require 'date'
require 'wice_grid'

class DashboardController < ApplicationController
  include DashboardHelper
  attr_accessor :client_ID

  def index
    if(!client_signed_in?)
      redirect_to '/'
    end

    @client_ID = current_client.id
    @person = Person.find_by(client_id: current_client.id)
    flash[:success] = 'Welcome, ' + @person.name_first + ' to the Dashboard!'

    calcAllEvents
  end

  def add_event
    redirect_to '/events/new'
  end
end
