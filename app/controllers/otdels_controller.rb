class OtdelsController < ApplicationController
  before_action :set_otdel, only: [:show, :edit, :update, :destroy]

  # GET /otdels
  # GET /otdels.json
  def index
    @items  = Otdel.order(:name)  
    @item = Otdel.new
  end

  # GET /otdels/1
  # GET /otdels/1.json
  def show
  end

  # GET /otdels/new
  def new
    @otdel = Otdel.new
  end

  # GET /otdels/1/edit
  def edit
  end

  # POST /otdels
  # POST /otdels.json
  def create
    @otdel = Otdel.new(otdel_params)

    respond_to do |format|
      if @otdel.save
        format.html { redirect_to otdels_url, notice: 'Otdel was successfully created.' }
        format.json { render :show, status: :created, location: @otdel }
      else
        format.html { render :new }
        format.json { render json: @otdel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /otdels/1
  # PATCH/PUT /otdels/1.json
  def update
    respond_to do |format|
      if @otdel.update(otdel_params)
        format.html { redirect_to otdels_url, notice: 'Otdel was successfully updated.' }
        format.json { render :show, status: :ok, location: @otdel }
      else
        format.html { render :edit }
        format.json { render json: @otdel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /otdels/1
  # DELETE /otdels/1.json
  def destroy
    @otdel.destroy
    respond_to do |format|
      format.html { redirect_to otdels_url, notice: 'Otdel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_otdel
      @otdel = Otdel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def otdel_params
      params.require(:otdel).permit(:name)
    end
end
