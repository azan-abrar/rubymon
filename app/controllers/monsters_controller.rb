class MonstersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_monster, only: [:show, :edit, :update, :destroy]

  # GET /monsters
  # GET /monsters.json
  def index
    @monsters = Monster.order(sort_column + " " + sort_direction)
  end

  # GET /monsters/1
  # GET /monsters/1.json
  def show
  end

  # GET /monsters/new
  def new
    @monster = Monster.new
  end

  # GET /monsters/1/edit
  def edit
  end

  # POST /monsters
  # POST /monsters.json
  def create
    if current_user.monsters.count > 20
      redirect_to monsters_url, alert: 'You have already added 20 monsters.'
    else  
      @monster = Monster.new(monster_params)
      @monster.user_id = current_user
      respond_to do |format|
        if @monster.save
          format.html { redirect_to @monster, notice: 'Monster was successfully created.' }
          format.json { render :show, status: :created, location: @monster }
        else
          format.html { render :new }
          format.json { render json: @monster.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  # PATCH/PUT /monsters/1
  # PATCH/PUT /monsters/1.json
  def update
    respond_to do |format|
      if @monster.update(monster_params)
        format.html { redirect_to @monster, notice: 'Monster was successfully updated.' }
        format.json { render :show, status: :ok, location: @monster }
      else
        format.html { render :edit }
        format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monsters/1
  # DELETE /monsters/1.json
  def destroy
    @monster.destroy
    respond_to do |format|
      format.html { redirect_to monsters_url, notice: 'Monster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monster
      @monster = Monster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monster_params
      params.require(:monster).permit(:name, :power, :monster_type)
    end

    def sort_column
      Monster.column_names.include?(params[:sort]) ? params[:sort] : 'name'
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
