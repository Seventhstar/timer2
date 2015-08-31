module UsedTimesHelper

  def otdel_name(otdel_id)
      if otdel_id 
         otdel = Otdel.find(otdel_id)
         if otdel 
            otdel.name 
         else 
            ""
         end
      else
         ""
      end
  end

  def pad2(number,suffics) 
       num = number.to_i             
      (num == 0 ? "" : ((num < 10 ? '0' : '') + num.to_s + suffics))
  end 


  def format_time(seconds)
        x = seconds;
        millisec = 0;
        seconds = x%60;
        x = x/60;
        minutes = x % 60;
        x = x/60;
        hours = x % 24;
        
        [pad2(hours,'h '), pad2(minutes, "m "), pad2(seconds, "s ")].join("");

  end

  def time_for_otdel(otdel_id)
      #@otdel_times = UsedTime.order("otdel_id, created_at desc").where("DATE(created_at) = DATE(?) and otdel_id =? ", Time.now.where, otdel_id)
      @otdel_times = UsedTime.order("otdel_id, created_at desc").where "otdel_id =? and user_id=? and DATE(created_at)=DATE(?)", otdel_id, current_user.id,Time.now
  end
end
