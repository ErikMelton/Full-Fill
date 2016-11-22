class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new(person_id: current_client.id)
    @person = Person.find_by(client_id: current_client.id)
    @activities = Activity.all
    @activityIDs = []
    @activityNames = []
    @activities.each do |item|
      @activityIDs << item.activity_spec_id
      @activityNames << item.activityname
    end
    @hours = 0
  end

  # GET /events/1/edit
  def edit
    @person = Person.find_by(client_id: current_client.id)
  end

  # POST /events
  # POST /events.json
  def create
    @person = Person.find_by(client_id: current_client.id)
    @activities = Activity.all
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to '/dashboard/index', notice: 'Event was successfully created.' }
      else
        format.html { render :new }
      end
    end

    activity_spec = Activity.where(activity_spec_id: @event.activity_id).first
    trait_spec = Trait.where(trait_spec_id: activity_spec.trait_id).first
    facettype = Facet.where(id: trait_spec.facet_id).first.facettype
    if(facettype == 'physical') then
      score = @person.physical_score.to_i + @event.activity_hours.to_i
      @person.update_column(:physical_score, score)
    elsif(facettype == 'expressive') then
      score = @person.expressive_score.to_i + @event.activity_hours.to_i
      @person.update_column(:expressive_score, score)
    elsif(facettype == 'creative') then
      score = @person.creative_score.to_i + @event.activity_hours.to_i
      @person.update_column(:creative_score, score)
    elsif(facettype == 'abstract') then
      score = @person.abstract_score.to_i + @event.activity_hours.to_i
      @person.update_column(:abstract_score, score)
    elsif(facettype == 'social') then
      score = @person.social_score.to_i + @event.activity_hours.to_i
      @person.update_column(:social_score, score)
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:activity_id, :activity_hours, :activity_note, :activity_place, :activity_when, :person_id)
    end
end
