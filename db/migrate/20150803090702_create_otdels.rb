class CreateOtdels < ActiveRecord::Migration
  def change
    create_table :otdels do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
