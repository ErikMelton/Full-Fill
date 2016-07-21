class Activity < ActiveRecord::Base
  attr_accessible :activityname, :activity_desc, :trait_id, :activity_note
end
