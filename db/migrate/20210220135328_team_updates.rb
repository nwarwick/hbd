class TeamUpdates < ActiveRecord::Migration[5.2]
  def change
    change_column_null :teams, :domain, true
    add_column :teams, :name, :string
  end
end
