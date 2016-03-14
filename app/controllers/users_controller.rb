class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :add_skills, :finish_signup]
  before_action :set_skills, only: [:show, :edit, :update, :destroy, :add_skills]
  before_action :set_all_skills, only: [:new, :add_skills, :edit]
  before_action :set_user_skills, only: [:new, :add_skills, :edit]
  prepend_before_action :new_user, only: [:new]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
  end

  # GET /users/add_skill
  def add_skills
    # @user.skills << Skill.find(params[:skill_id])
  end

  def add_powers

  end

  def register
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
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
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
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
    @skills = User.find(params[:id]).skills
  end

  def set_all_skills
    @all_skills = Skill.all
  end

  def set_user_skills
    @user_skills = @user.user_skills.build
  end

  def new_user
    @user = User.new
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    #params.require(:user).permit(:name, :email, :password, :password_confirmation)
    accessible = [ :name, :email, :id ] # extend with your own params
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end
end
