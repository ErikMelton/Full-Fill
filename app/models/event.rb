class Event < ActiveRecord::Base
  has_one :activity
  # attr_accessable :person_id, :activity_hours, :activity_note, :activity_place, :activity_when
end
