class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.boolean :fixed, :default => false
      t.boolean :personal,:default => false
      t.datetime :start_date

      t.timestamps null: false
    end
  end
end
