# frozen_string_literal: true

class CreateForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :forecasts do |t|
      t.string :data_str, null: false
      t.string :place_id, null: false
      t.string :postal_code, null: true

      t.timestamps
    end

    add_index :forecasts, :postal_code
  end
end
