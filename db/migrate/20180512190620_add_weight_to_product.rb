class AddWeightToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :weight, :decimal, precision: 10, scale: 5, default: 0.0
    add_column :api_calculations, :average_cubic_weight, :decimal, precision: 10, scale: 5
    add_column :api_calculations, :category, :string
    remove_column :api_request_logs, :domain
  end
end
