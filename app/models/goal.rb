class Goal < ActiveRecord::Base
  belongs_to :priority #, foreign_key: :priority_id
end
