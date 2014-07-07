class AddDataToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :data, :string
  end
end
