class UsersController < ApplicationController

	def index
		@users = User.all
		@ribbit = Ribbit.new
	end
	
	def new
		if current_user
			redirect_to buddies_path
		else
			@user = User.new
		end
		
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to @user, notice: "Thank you for signing up for Ribbit"
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@ribbit= Ribbit.new
		@relationship = Relationship.where(
			follower_id: current_user,
			followed_id: @user.id
			).first_or_initialize if current_user
	end

	def buddies
		if current_user
			@ribbit = Ribbit.new
			buddies_ids = current_user.followeds.map(&:id).push(current_user.id)
			@ribbits = Ribbit.where(user_id: buddies_ids)
		else
			redirect_to root_path
		end
	end

	def edit
		@user = User.find(params[:id])

		redirect_to @user unless @user == current_user
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to @user, notice: "Profile updated!"
		else
			render 'edit'
		end
	end
private

	def user_params
		params.require(:user).permit(:avatar_url, :bio, :email, :name, :password, :password_confirmation, :username)
	end
end
