class AddQaUserLimitToQuestionnaires < ActiveRecord::Migration
  def change
    add_column :questionnaires, :qa_user_limit, :integer
  end
end
