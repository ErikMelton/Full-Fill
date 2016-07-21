class Event < ActiveRecord::Base
  attr_accessable :person_id, :activity_hours, :activity_note, :activity_place, :activity_when
end
