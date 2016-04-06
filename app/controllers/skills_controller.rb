class SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /skills
  # GET /skills.json
  def index
    @search = params[:search]
    @skills = Skill.search(params[:search])
    
  end
  
  def search
  search_skill
  end 
  
  def endorseskill 
  
    @userskill=UserSkill.find_by(user_id: params[:endorseUser], skill_id: params[:endorseSkill])
    @target_user = User.find(params[:endorseUser])
    @target_skill = Skill.find(params[:endorseSkill])
    @competence=@userskill.competence
    @userskill.competence= @competence +1
    if @userskill.competence == 5
        @target_user.add_role :assessor, @target_skill
    end
    @userskill.save
    refresh_search_skill
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
  end

  # GET /skills/new
  def new
    @skill = Skill.new
  end

  # GET /skills/1/edit
  def edit
  end

  # POST /skills
  # POST /skills.json
  def create
    @skill = Skill.new(skill_params)

    respond_to do |format|
      if @skill.save
        format.html { redirect_to '/skills', notice: 'Skill was successfully created.' }
        format.json { render :show, status: :created, location: @skill }
      else
        format.html { render :new }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skills/1
  # PATCH/PUT /skills/1.json
  def update
    respond_to do |format|
      if @skill.update(skill_params)
        format.html { redirect_to '/skills', notice: 'Skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @skill }
      else
        format.html { render :edit }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skills/1
  # DELETE /skills/1.json
  def destroy
    @skill.destroy
    respond_to do |format|
      format.html { redirect_to skills_url, notice: 'Skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_params
      params.require(:skill).permit(:name, :category, :search)
    end
    def search_skill
    @skillSearch= params[:search]
    @skillId=Skill.select("id").find_by name: params[:search]
    if @skillId
      @searchedUsers=UserSkill.where(skill_id: @skillId).select("user_id","skill_id","competence")
      render :action => :search_skill_assessor
    else
      respond_to do |format|
        format.html { redirect_to skills_path, notice: "Skill does not exist" }
        format.json { head :no_content }
      end
    end
  end

  def refresh_search_skill
    @skillId=params[:endorseSkill]
    @skillSearch= Skill.find(@skillId).name
    @searchedUsers=UserSkill.where(skill_id: @skillId).select("user_id","skill_id","competence")
    render :action => :search_skill_assessor
  end
end
