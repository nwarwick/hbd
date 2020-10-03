# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :domain, null: false, unique: true, limit: 320
      t.string :slack_id, null: false, unique: true, limit: 320

      t.timestamps
    end
  end
end
