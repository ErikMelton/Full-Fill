require 'csv'

desc "Import sample data from CSV"
task :import => [:environment] do
  file_trait = "db/Trait.csv"
  file_activity = "db/Activity.csv"
  file_event = "db/Event.csv"

  CSV.foreach(file_trait, :headers => true) do |row|
    Trait.create(traitname: row[1], trait_desc: row[1].to_s.capitalize, facet_id: row[3], trait_spec_id: row[0])
  end

  CSV.foreach(file_activity, :headers => true) do |row|
    Activity.create(activityname: row[1], activity_desc: row[2].to_s.capitalize, trait_id: row[3], activity_spec_id: row[0])
  end

  CSV.foreach(file_event, :headers => true) do |row|
    Event.create(person_id: row[0], activity_hours: row[3], activity_note: row[4], activity_place: row[5], activity_when: row[1], activity_id: row[2])
  end
end