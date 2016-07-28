require 'date'

class DashboardController < ApplicationController
  def index
    if(!client_signed_in?)
      redirect_to '/'
    end

    @person = Person.find_by(client_id: current_client.id)
    flash[:success] = 'Welcome, ' + @person.name_first + ' to the Dashboard!'

    @events = Event.where(person_id: @person.id)
    @physical = @events.where(facet_id: 1)
    @expressive = @events.where(facet_id: 2)
    @creative = @events.where(facet_id: 3)
    @abstract = @events.where(facet_id: 4)
    @social = @events.where(facet_id: 5)

    calc_age_range
  end

  def calc_age_range
    @ageArr = []
    @birthYear = Date.strptime(@person.birth_date, "%m/%d/%Y").year.to_i
    @currentYear = Date.today.year.to_i

    @difference = @currentYear - @birthYear

    for i in 0..@difference do
      @ageArr[i] = i
    end

    # raise @difference.to_s

  end
end
