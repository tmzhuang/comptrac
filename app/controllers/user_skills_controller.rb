class UserSkillsController < ApplicationController
  before_action :set_user_skill, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  # skip_callback(:search ,:before, :set_user_skill)

  # GET /user_skills
  # GET /user_skills.json
  def index
    @user_skills = UserSkill.all
  end

  # GET /user_skills/1
  # GET /user_skills/1.json
  def show
  end

  # GET /user_skills/new
  def new
    @user_skill = UserSkill.new
  end

  # GET /user_skills/1/edit
  def edit
  end


  def search
    if params[:select]== "users"
      search_user
    else
      search_skill
    end
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

  def endorseuser
    @target_user = User.find(params[:endorseUser])
    @target_skill = Skill.find(params[:endorseSkill])
    @userskill=UserSkill.find_by(user_id: params[:endorseUser], skill_id: params[:endorseSkill])
    @competence=@userskill.competence
    @userskill.competence= @competence +1
    if @userskill.competence == 5
        @target_user.add_role :assessor, @target_skill
    end
    @userskill.save
    refresh_search_user
  end

  # POST /user_skills
  # POST /user_skills.json
  def create
    @user_skill = UserSkill.new(user_skill_params)

    respond_to do |format|
      if @user_skill.save
        format.html { redirect_to @user_skill, notice: 'User skill was successfully created.' }
        format.json { render :show, status: :created, location: @user_skill }
      else
        format.html { render :new }
        format.json { render json: @user_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_skills/1
  # PATCH/PUT /user_skills/1.json
  def update
    respond_to do |format|
      if @user_skill.update(user_skill_params)
        format.html { redirect_to @user_skill, notice: 'User skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_skill }
      else
        format.html { render :edit }
        format.json { render json: @user_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_skills/1
  # DELETE /user_skills/1.json
  def destroy
    @user_skill.destroy
    respond_to do |format|
      format.html { redirect_to user_skills_url, notice: 'User skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


  # Use callbacks to share common setup or constraints between actions.
  def set_user_skill
    if params[:id]!="search"
      @user_skill = UserSkill.find(params[:id])
    end
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def user_skill_params
    params.require(:user_skill).permit(:competence)
  end


  def search_user
    @id=User.select("id").find_by name: params[:searchBy]
    if @id
      @user = User.find(@id)
      @skills = @user.skills
      #respond_to do |format|
      #format.html { redirect_to "user_skills/search_user", notice: 'User was successfully shown.' }
      #format.json { head :no_content }
      #end
      render :action => :search_user
    else
      respond_to do |format|
        format.html { redirect_to user_skills_path, notice: "User does not exist" }
        format.json { head :no_content }
      end
    end
  end

  def search_skill
    @skillSearch= params[:searchBy]
    @skillId=Skill.select("id").find_by name: params[:searchBy]
    if @skillId
      @searchedUsers=UserSkill.where(skill_id: @skillId).select("user_id","skill_id","competence")
      render :action => :search_skill_assessor
    else
      respond_to do |format|
        format.html { redirect_to user_skills_path, notice: "Skill does not exist" }
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

  def refresh_search_user
    @id=params[:endorseUser]
    @user = User.find(@id)
    @skills = @user.skills
    #respond_to do |format|
    #format.html { redirect_to "user_skills/search_user", notice: 'User was successfully shown.' }
    #format.json { head :no_content }
    #end
    render :action => :search_user
  end

end