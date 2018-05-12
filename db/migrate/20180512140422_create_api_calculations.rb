class CreateApiCalculations < ActiveRecord::Migration[5.2]
  def change
    create_table :api_calculations do |t|
      t.boolean :finished, null: false, default: false
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration

      t.timestamps
    end
    add_index :api_calculations, :finished
  end
end
