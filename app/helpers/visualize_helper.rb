module VisualizeHelper
  def calcAllEvents
    @events = Event.where(person_id: @person.id)
    @person_grid = initialize_grid(@events, order: 'events.activity_when', order_direction: 'desc')

    @physical = []
    @expressive = []
    @creative = []
    @abstract = []
    @social = []

    calc_age_range
    calc_scores
    getTopThreeEvents
  end

  def getTopThreeEvents
    @sortedEvents = @events.sort_by { |obj| obj.activity_hours }.reverse
    @topEvent = @sortedEvents[0];
    @secondEvent = @sortedEvents[1];
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
        @physical.push(event)
      elsif(facet_spec.facettype == "expressive")
        @expressive.push(event)
      elsif(facet_spec.facettype == "creative")
        @creative.push(event)
      elsif(facet_spec.facettype == "abstract")
        @abstract.push(event)
      elsif(facet_spec.facettype == "social")
        @social.push(event)
      end
    end
  end
end
