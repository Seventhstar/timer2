class CreateUtTypes < ActiveRecord::Migration
  def change
    create_table :ut_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
