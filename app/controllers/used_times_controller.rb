class UsedTimesController < ApplicationController
  before_action :logged_in_user

  def index
    @otdels = Otdel.all 
    @utypes = UtType.all
    @tasks  = Task.all
      #@used_times = UsedTime.order("otdel_id, created_at desc").where "DATE(created_at) = DATE(?)", Time.now
      # .where "DATE(created_at) = DATE(?)", Time.now
#      @gr_otdel = UsedTime.select("otdel_id, SUM(seconds)").where("DATE(created_at) = DATE(?)", Time.now).group_by(&:otdel_id)
       @gr_otdel = UsedTime.group(:otdel_id)
                           .select("otdel_id, SUM(seconds) as time")
                           .where("DATE(created_at) = DATE(?) and user_id=?", Time.now, current_user)
                           .collect{ |rec| [rec.otdel_id, rec.time]}  
       p "gr_otdel",@gr_otdel
#where("DATE(created_at) = DATE(?)", Time.now) 
#      @gr_otdel = UsedTime.where("DATE(created_at) = DATE(?)", Time.now)

#    @used_times = UsedTime.all
#.where(:hidden => (params[:hidden] == "1"))
#.order("created_at desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @used_times }
    end
  end

  def destroy
    UsedTime.find(params[:id]).destroy
    flash[:success] = "удален"
    redirect_to used_times_url
  end

  private

    def used_time_params
      params.require(:used_time).permit(:otdel_id, :seconds, :user_id, :ut_type_id, :task_id)
    end
end

