class AddOrderToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :sort_order, :integer
  end
end
