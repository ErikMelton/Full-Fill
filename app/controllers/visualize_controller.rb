class VisualizeController < ApplicationController
  include VisualizeHelper

  def index
    if(!client_signed_in?)
      redirect_to '/'
    end

    @client_ID = current_client.id
    @person = Person.find_by(client_id: current_client.id)

    calcAllEvents
  end

  def report
  end
end
