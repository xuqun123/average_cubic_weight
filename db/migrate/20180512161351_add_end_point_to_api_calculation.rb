class AddEndPointToApiCalculation < ActiveRecord::Migration[5.2]
  def change
    add_column :api_calculations, :endpoint, :string
    add_column :api_calculations, :conversion_factor, :integer
    add_index :api_calculations, :endpoint
  end
end
