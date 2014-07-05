class AddDataToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :data, :string
  end
end
