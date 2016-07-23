class Activity < ActiveRecord::Base
  has_one :trait
  # attr_accessible :activityname, :activity_desc, :trait_id, :activity_note
end
