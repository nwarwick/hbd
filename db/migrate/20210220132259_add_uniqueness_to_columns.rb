class AddUniquenessToColumns < ActiveRecord::Migration[5.2]
  def change
    add_index :teams, :slack_id, unique: true
    add_index :users, :slack_id, unique: true
  end
end
