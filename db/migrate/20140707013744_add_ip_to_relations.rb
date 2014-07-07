class AddIpToRelations < ActiveRecord::Migration
  def change
  	add_column :relations, :ip, :string
  end
end
