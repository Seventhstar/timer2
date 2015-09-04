class AjaxController < ApplicationController


   def upd_param
     if params['model'] && params['model']!='undefined'
      puts params        
      obj = Object.const_get(params['model']).find(params['id'])
      #puts obj.class
      if params['model']=='WhouseElement'
        if obj.element_name != params['upd']['element_name']
          el = obj.element
          el.name = params['upd']['element_name']
          el.save
        end
        if obj.count != params['upd']['count']
          obj.count = params['upd']['count']
          obj.save
        end
        else  

          #new_name = params['upd']['name'].present? ? params['upd']['name'] : params['upd']['undefined']
          ## if obj.name != new_name
          #obj.name  = new_name
          #obj.save
          params['upd'].each do |p|
            #puts p
            obj[p[0]] = p[1]
            #obj   
         end
         obj.save
        end   
     end
     render :nothing => true
   end

   def save_last_time
      if params[:otdel]
         last_time = UsedTime.new( :otdel_id => params[:otdel], 
                                   :seconds => params[:last_time], 
                                   :ut_type_id => params[:ut_type_id],
                                   :task_id => params[:task_id],
                                   :user_id => current_user.id)
         last_time.save
      end

    respond_to do |format|
      format.html { render :text => "Rescued HTML" }
      format.js { render :action => "errors" }
    end

   end


   def save_new_otdel
      if params[:otdel_name]
         new_otdel = Otdel.find_by_name(params[:otdel_name])
          if new_otdel
             msg = ["Otdel ","'",params[:otdel_name],"'"," already exists!"].join(" ")
             flash[:error] = msg
          else
              new_otdel = Otdel.new
              new_otdel.name = params[:otdel_name]
              new_otdel.save
              msg = ["Otdel ","'",params[:otdel_name],"'"," successfuly saved!"].join(" ")
              flash[:success] = msg
          end
      end

    respond_to do |format|
      format.html { render :text => "Rescued HTML" }
      format.js { render :action => "errors" }
    end

   end

 def save_new_task
      if params[:task_name]
         new_task = Task.find_by_name(params[:task_name])
          if new_task
             msg = ["Task ","'",params[:task_name],"'"," already exists!"].join(" ")
             flash[:error] = msg
          else
              new_task = Task.new
              new_task.name = params[:task_name]
              new_task.save
              msg = ["Task ","'",params[:task_name],"'"," successfuly saved!"].join(" ")
              flash[:success] = msg
          end
      end

    respond_to do |format|
      format.html { render :text => "Rescued HTML" }
      format.js { render :action => "errors" }
    end

   end

end
