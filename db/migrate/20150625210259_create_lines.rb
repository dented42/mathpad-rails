class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.references :scratchpad, null: false, foreign_key: true
      t.integer :order, null: false

      t.index [:scratchpad_id, :order], unique: true
      
      t.text :content, null: false

      t.timestamps null: false
    end

    
  end
end
