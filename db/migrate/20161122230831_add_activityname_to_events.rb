class AddActivitynameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :activityname, :string
  end
end
