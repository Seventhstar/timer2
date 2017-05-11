class AddPriorityToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :priority_id, :integer
  end
end
