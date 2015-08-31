class CreateUsedTimes < ActiveRecord::Migration
  def change
    create_table :used_times do |t|
      t.integer :otdel_id
      t.float :seconds
      t.integer :user_id
      t.integer :ut_type_id
      t.integer :task_id

      t.timestamps null: false
    end
  end
end
