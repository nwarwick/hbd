class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 320
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
