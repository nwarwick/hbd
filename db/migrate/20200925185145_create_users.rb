# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 320
      t.string :slack_id, null: false, limit: 320, unique: true
      t.references :team, null: false, foreign_key: true
      t.datetime :birthday, null: false

      t.timestamps
    end
  end
end
