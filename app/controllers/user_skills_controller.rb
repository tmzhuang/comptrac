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
	
  
	

  # POST /user_skills
  # POST /user_skills.json
  def create
    @user_skill = UserSkill.new(user_skill_params)
    @user_skill.user = User.find(user_skill_params[:user_id])
    @user_skill.skill = Skill.find(user_skill_params[:skill_id])

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
      params.require(:user_skill).permit(:competence, :user_id, :skill_id)
    end
def search_user
    @id=User.select("id").find_by name: params[:searchBy]
    @user = User.find(@id) 
  @skills = @user.skills
     #respond_to do |format|
      #format.html { redirect_to "user_skills/search_user", notice: 'User was successfully shown.' }
      #format.json { head :no_content }
    #end
  render :action => :search_user
  end
  def search_skill
	@skillSearch= params[:searchBy]
	@skillId=Skill.select("id").find_by name: params[:searchBy]
	@searchedUsers=UserSkill.where(skill_id: @skillId).select("user_id","competence")
  
  render :action => :search_skill_assessor
	

  end

end
