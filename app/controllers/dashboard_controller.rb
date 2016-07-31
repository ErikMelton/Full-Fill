require 'date'

class DashboardController < ApplicationController
  def index
    if(!client_signed_in?)
      redirect_to '/'
    end

    @person = Person.find_by(client_id: current_client.id)
    flash[:success] = 'Welcome, ' + @person.name_first + ' to the Dashboard!'

    @events = Event.where(person_id: @person.id)

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
    input_activities
    input_events
    calc_scores

  end

  def add_row

  end

  def modes(array, find_all=true)
    histogram = array.inject(Hash.new(0)) { |h, n| h[n] += 1; h }
    modes = nil
    histogram.each_pair do |item, times|
      modes << item if modes && times == modes[0] and find_all
      modes = [times, item] if (!modes && times>1) or (modes && times>modes[0])
    end

    return modes ? modes[1...modes.size] : modes
  end

  def input_events
    ageModeArray = []

    @events.each do |event|
      ageModeArray.push(event.activity_when)
    end

    ageMode = modes(ageModeArray)
  end

  def input_activities
    @activities = Activity.all()

    @physString = ''
    @expressString = ''
    @creativeString = ''
    @abstractString = ''
    @socialString = ''

    @activities.each do |activity|
      trait_spec = Trait.where(trait_spec_id: activity.trait_id).first
      facet_spec = Facet.where(id: trait_spec.facet_id).first

      if(facet_spec.facettype == "physical")
        key = activity.activityname
        name = activity.activityname.split.map(&:capitalize).join(' ')
        @physString << '"' + "#{key}" + '"' + ':' + '"' + "#{name}" + '"' + ','
      end
      if(facet_spec.facettype == "expressive")
        key = activity.activityname
        name = activity.activityname.split.map(&:capitalize).join(' ')
        @expressString << '"' + "#{key}" + '"' + ':' + '"' + "#{name}" + '"' + ','
      end
      if(facet_spec.facettype == "creative")
        key = activity.activityname
        name = activity.activityname.split.map(&:capitalize).join(' ')
        @creativeString << '"' + "#{key}" + '"' + ':' + '"' + "#{name}" + '"' + ','
      end
      if(facet_spec.facettype == "abstract")
        key = activity.activityname
        name = activity.activityname.split.map(&:capitalize).join(' ')
        @abstractString << '"' + "#{key}" + '"' + ':' + '"' + "#{name}" + '"' + ','
      end
      if(facet_spec.facettype == "social")
        key = activity.activityname
        name = activity.activityname.split.map(&:capitalize).join(' ')
        @socialString << '"' + "#{key}" + '"' + ':' + '"' + "#{name}" + '"' + ','
      end
    end
    @physString = @physString[0...-1] + '}'
    @physString = @physString.insert(0, "{");
    @expressString = @expressString[0...-1] + '}'
    @expressString = @expressString.insert(0, "{");
    @creativeString = @creativeString[0...-1] + '}'
    @creativeString = @creativeString.insert(0, "{");
    @abstractString = @abstractString[0...-1] + '}'
    @abstractString = @abstractString.insert(0, "{");
    @socialString = @socialString[0...-1] + '}'
    @socialString = @socialString.insert(0, "{");
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
