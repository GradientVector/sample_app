class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
	before_filter :banned_action_for_signed_in_user, only: [:new, :create]
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: :destroy
  
  def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
		@user = User.new
  end
  
  def create
		@user = User.new(params[:user])
		if @user.save
			# Handle a successful save.
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
  end  
  
  def index
		@users = User.paginate(page: params[:page])
  end
  
  def edit
  end
  
  def update	
		if @user.update_attributes(params[:user])
			# Handle a successful update.
			sign_in @user
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render "edit"
		end
  end
  
  def destroy
		user = User.find(params[:id])
		unless current_user?(user)
			user.destroy
			flash[:success] = "User destroyed."
			redirect_to users_url
		else
			redirect_to root_path, notice: "Admin users are not allowed to destroy themselves."
		end
  end
  
  private		
		def banned_action_for_signed_in_user
			if signed_in?
				redirect_to root_path, notice: "Signed-in users are not allowed to create a new user account."
			end
		end
		
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
		
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
