module ReportHelper
  def generateReport(events)
    @viewReport = true

    @person_events = events;

    @physical_events = []
    @physical_hours = 0
    physical_traits = []
    phystemp = Trait.where(facet_id: 1)
    phystemp.each do |temp|
      physical_traits.push(temp.traitname)
    end

    @expressive_events = []
    @expressive_hours = 0
    expressive_traits = []
    expresstemp = Trait.where(facet_id: 2)
    expresstemp.each do |temp|
      expressive_traits.push(temp.traitname)
    end

    @creative_events = []
    @creative_hours = 0
    creative_traits = []
    creativetemp = Trait.where(facet_id: 3)
    creativetemp.each do |temp|
      creative_traits.push(temp.traitname)
    end

    @abstract_events = []
    @abstract_hours = 0
    abstract_traits = []
    abstrtemp = Trait.where(facet_id: 4)
    abstrtemp.each do |temp|
      abstract_traits.push(temp.traitname)
    end

    @social_events = []
    @social_hours = 0
    social_traits = []
    soctemp = Trait.where(facet_id: 5)
    soctemp.each do |temp|
      social_traits.push(temp.traitname)
    end

    @person_events.each do |event|
      activity_spec = Activity.where(activity_spec_id: event.activity_id).first
      trait_spec = Trait.where(trait_spec_id: activity_spec.trait_id).first
      facettype = Facet.where(id: trait_spec.facet_id).first.facettype
      if(facettype == 'physical') then
        @physical_events.push(event)
        @physical_hours = @physical_hours + event.activity_hours
      elsif(facettype == 'expressive') then
        @expressive_events.push(event)
        @expressive_hours + @expressive_hours + event.activity_hours
      elsif(facettype == 'creative') then
        @creative_events.push(event)
        @creative_hours = @creative_hours + event.activity_hours
      elsif(facettype == 'abstract') then
        @abstract_events.push(event)
        @abstract_hours = @abstract_hours + event.activity_hours
      elsif(facettype == 'social') then
        @social_events.push(event)
        @social_hours = @social_hours + event.activity_hours
      end
    end
  end

  def getTotalHours
    @totalHours = 0
    @events.each do |event|
      @totalHours = @totalHours + event.activity_hours.to_i
    end
    return @totalHours.to_s
  end
end
