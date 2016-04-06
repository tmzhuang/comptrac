class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :add_skills]
  before_action :set_skills, only: [:show, :edit, :update, :destroy, :add_skills]
  before_action :set_all_skills, only: [:new, :add_skills, :edit]
  before_action :set_user_skills, only: [:new, :add_skills, :edit]
  skip_before_filter :verify_authenticity_token
  # GET /users
  # GET /users.json
  def index
    @users = User.all.search(params[:search])
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end
  
  def search
    search_user
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
      else  def search_user
    @id=User.select("id").find_by name: params[:searchBy]
    if @id
      @user = User.find(@id)
      @skills = @user.skills
      #respond_to do |format|
      #format.html { redirect_to "user_skip_before_filter :verify_authenticity_tokenskills/search_user", notice: 'User was successfully shown.' }
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
        format.json { render :show, status: :ok, location: @userAli }
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
      params.require(:user).permit(:name, :search)
    end
    
    
    def search_user
      @id=User.select("id").find_by name: params[:search]
    if @id
      @user = User.find(@id)
      @skills = @user.skills
      #respond_to do |format|
      #format.html { redirect_to "user_skip_before_filter :verify_authenticity_tokenskills/search_user", notice: 'User was successfully shown.' }
      #format.json { head :no_content }
      #end
      render :action => :search_user
    else
      respond_to do |format|
        format.html { redirect_to users_path, notice: "User does not exist" }
        format.json { head :no_content }
      end
    end
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
