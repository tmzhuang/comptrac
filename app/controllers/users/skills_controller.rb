class Users::SkillsController < ApplicationController
  before_action :set_user_skill, only: [:show, :edit, :update, :destroy]

  # GET /user/skills
  # GET /user/skills.json
  def index
    @user_skills = current_user.skills
  end

  # GET /user/skills/1
  # GET /user/skills/1.json
  def show
  end

  # GET /user/skills/new
  def new
    @user_skill = User::Skill.new
  end

  # GET /user/skills/1/edit
  def edit
  end

  # POST /user/skills
  # POST /user/skills.json
  def create
    @user_skill = User::Skill.new(user_skill_params)

    respond_to do |format|
      if @user_skill.save
        format.html { redirect_to '/user_skills', notice: 'Skill was successfully created.' }
        format.json { render :show, status: :created, location: @user_skill }
      else
        format.html { render :new }
        format.json { render json: @user_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/skills/1
  # PATCH/PUT /user/skills/1.json
  def update
    respond_to do |format|
      if @user_skill.update(user_skill_params)
        format.html { redirect_to '/user_skills', notice: 'Skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_skill }
      else
        format.html { render :edit }
        format.json { render json: @user_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/skills/1
  # DELETE /user/skills/1.json
  def destroy
    @user_skill.destroy
    respond_to do |format|
      format.html { redirect_to user_skills_url, notice: 'Skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_skill
      @user_skill = User::Skill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_skill_params
      accessible = [ :name, :email, :id ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.fetch(:user_skill, {}).permit(accessible)
    end
end
