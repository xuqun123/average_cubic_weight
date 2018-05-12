class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :category
      t.string :title
      t.decimal :length, :precision => 10, :scale => 6, default: 0.0
      t.decimal :width, :precision => 10, :scale => 6, default: 0.0
      t.decimal :height, :precision => 10, :scale => 6, default: 0.0
      t.decimal :volume, :precision => 10, :scale => 6
      t.decimal :cubic_weight, :precision => 10, :scale => 5

      t.timestamps
    end
    add_index :products, :category
  end
end
