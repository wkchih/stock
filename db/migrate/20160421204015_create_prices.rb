class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :company_id
      t.float :price
      t.integer :volumne
      t.datetime :timestamp

      t.timestamps null: false
    end
  end
end
