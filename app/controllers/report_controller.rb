class ReportController < ApplicationController
  include ReportHelper

  def index
    @person = Person.find_by(client_id: current_client.id)
    @events = Event.where(person_id: @person.id)
    @totalHours = getTotalHours
    @viewReport = false
    generateReport(@events)
  end
end
