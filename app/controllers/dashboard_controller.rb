require 'date'
require 'wice_grid'

class DashboardController < ApplicationController
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

  def calcAllEvents
    @events = Event.where(person_id: @person.id)
    @person_grid = initialize_grid(@events, order: 'events.activity_when', order_direction: 'desc')

    @physical = nil
    @expressive = nil
    @creative = nil
    @abstract = nil
    @social = nil

    @physScore = 0
    @expresScore = 0
    @creatScore = 0
    @abstractScore = 0
    @socialScore = 0

    @numOfActivityColumns = 4

    calc_age_range
    input_events
    calc_scores
    getTopThreeEvents
  end

  def getTopThreeEvents
    @sortedEvents = @events.sort_by { |obj| obj.activity_hours }.reverse
    @topEvent = @sortedEvents[0];
    @secondEvent = @sortedEvents[1];
  end

  def add_event
    redirect_to '/events/new'
  end

  def input_events
    ageModeArray = []

    @events.each do |event|
      ageModeArray.push(event.activity_when)
    end
  end

  def calc_age_range
    @ageArr = []
    @birthYear = Date.strptime(@person.birth_date, "%m/%d/%Y").year.to_i
    @currentYear = Date.today.year.to_i

    @difference = @currentYear - @birthYear

    for i in 0..@difference do
      @ageArr[i] = i
    end
  end

  def calc_scores
    @events.each do |event|
      activity_spec = Activity.where(activity_spec_id: event.activity_id).first
      trait_spec = Trait.where(trait_spec_id: activity_spec.trait_id).first
      facet_spec = Facet.where(id: trait_spec.facet_id).first

      if(facet_spec.facettype == "physical")
        @physScore = @physScore + event.activity_hours
      end
      if(facet_spec.facettype == "expressive")
        @expresScore = @expresScore + event.activity_hours
      end
      if(facet_spec.facettype == "creative")
        @creatScore = @creatScore + event.activity_hours
      end
      if(facet_spec.facettype == "abstract")
        @abstractScore = @abstractScore + event.activity_hours
      end
      if(facet_spec.facettype == "social")
        @socialScore = @socialScore + event.activity_hours
      end
    end
  end
end
