require 'date'
require 'wice_grid'

class DashboardController < ApplicationController
  def index
    if(!client_signed_in?)
      redirect_to '/'
    end

    @person = Person.find_by(client_id: current_client.id)
    flash[:success] = 'Welcome, ' + @person.name_first + ' to the Dashboard!'

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
  end

  def add_events
    activity = JSON.parse(params[:activity].to_json)['id']
    activity_id = Activity.find(activity).activity_spec_id
    activity_hours = params[:activity_hours]
    activity_note = params[:activity_note]
    activity_place = params[:activity_place]
    activity_when = params[:activity_when]

    person_id = Person.find_by(client_id: current_client.id).id

    event = Event.create(person_id: person_id.to_i, activity_hours: activity_hours.to_i, activity_note: activity_note.to_s, activity_place: activity_place.to_s, activity_when: activity_when.to_s, activity_id: activity_id.to_i)
    event.save

    redirect_to '/dashboard/index'
  end

  def add_event
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
