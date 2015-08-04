class CreateScratchpads < ActiveRecord::Migration
  def change
    create_table :scratchpads do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps null: false
    end
  end
end
