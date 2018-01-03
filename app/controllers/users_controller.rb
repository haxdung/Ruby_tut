class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @user
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = t "login_please"
        redirect_to login_url
      end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = t "deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def verify_admin
    redirect_to(root_url) unless current_user.admin?
  end

end
