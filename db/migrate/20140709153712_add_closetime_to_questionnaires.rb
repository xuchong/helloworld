class AddClosetimeToQuestionnaires < ActiveRecord::Migration
  def change
    add_column :questionnaires, :closetime, :datetime
  end
end
