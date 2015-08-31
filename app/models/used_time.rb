class UsedTime < ActiveRecord::Base
  belongs_to :otdel
  belongs_to :ut_type
  belongs_to :task

  def ut_type_name
	p "ut_type_id",ut_type_id 
      if ut_type_id 
	 p ut_type.name 
         ut_type.name 
         
      else
         ""
      end
  end


end
