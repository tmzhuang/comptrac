class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :add_skills]
  before_action :set_skills, only: [:show, :edit, :update, :destroy, :add_skills]
  before_action :set_all_skills, only: [:new, :add_skills, :edit]
  before_action :set_user_skills, only: [:new, :add_skills, :edit]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    authorize User
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/add_skill
  def add_skills
   # @user.skills << Skill.find(params[:skill_id])
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    
    # Grant admin priviledges if this is the only account
    if User.count == 0
      @user.add_role :admin
    end

    params[:user][:skill_ids].each do |id|
      if !id.empty?
        @user.skills << Skill.find(id)
      end
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
     end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    params[:user][:skill_ids].each do |id|
      if !id.empty?
        @user.skills << Skill.find(id)
      end
    end
   
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_skills
      @user_skills = @user.user_skills
    end

    def set_all_skills
      @all_skills = Skill.all
    end

    def set_user_skills
      @user_skills = @user.user_skills.build
     # @user_skills = UserSkill.find_by skill_id: 1, user_id: 1
    end
    def set_user_competence
     @user_competence=UserSkill.select("competence").find_by skill_id: 1, user_id: 1
    end

    def authorize_user
      authorize User
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name)
    end
end
