class UtTypesController < ApplicationController

  def index
    @items  = UtType.order(:name)  
    @item = UtType.new
  end


  # POST /otdels
  # POST /otdels.json
  def create
    @ut_type = UtType.new(ut_type_params)

    respond_to do |format|
      if @ut_type.save
        format.html { redirect_to ut_types_url, notice: 'ut_type was successfully created.' }
        format.json { render :show, status: :created, location: @ut_type }
      else
        format.html { render :new }
        format.json { render json: @ut_type.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def ut_type_params
      params.require(:ut_type).permit(:name)
    end


end



