class OptionsController < ApplicationController
# before_action :logged_in_user
 include OptionsHelper
  
  def index
    @items = option_model.order(:name)
    @item = option_model.new
  end

  def create
    #p params[:options_page]
    @item = option_model.new(options_params)
    @items  = option_model.order(:name)  
    respond_to do |format|
       if @item.save
         #format.js { render 'options/index', status: :created, location: @item, notice: 'Лид успешно создан.' }
         format.json { head :no_content }
       else
         format.js { render json: @item.errors, status: :unprocessable_entity }
       end
     end
  end

 def edit

    @page = params[:options_page]
    @page ||= "statuses"
    
    @items = option_model.order(:name)
    @item = option_model.new
    end

  # DELETE /absences/1
  # DELETE /absences/1.json
  def destroy
    @item = option_model.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end  
    
  private
  # Never trust parameters from the scary internet, only allow the white list through.
    def options_params
      i = option_model.model_name.singular
      params.require(i).permit(:name,:actual)
  end

    def option_model
      page = params[:options_page]
      page ||= "otdels"
      page.classify.constantize
    end
end
