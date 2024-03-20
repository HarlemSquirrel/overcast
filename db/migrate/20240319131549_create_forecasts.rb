class CreateForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :forecasts do |t|
      t.string :postal_code
      t.string :data_str

      t.timestamps
    end

    add_index :forecasts, :postal_code
  end
end
