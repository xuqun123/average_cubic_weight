class CreateApiRequestLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :api_request_logs do |t|
      t.string :domain
      t.string :endpoint
      t.text :response
      t.datetime :requested_time
      t.string :errors
			t.integer :api_calculation_id      

      t.timestamps
    end
    add_index :api_request_logs, :domain
    add_index :api_request_logs, :api_calculation_id
  end
end
