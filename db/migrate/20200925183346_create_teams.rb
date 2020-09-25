class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name, null: false, limit: 320
      t.string :token, null: false, unique: true, limit: 320

      t.timestamps
    end
  end
end
