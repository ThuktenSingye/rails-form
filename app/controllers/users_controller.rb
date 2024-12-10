class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # @user = User.new(username: params[:user][:username], password: params[:user][:password], email: params[:user][:password])
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "User updated successfully!"
      redirect_to new_user_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "User updated successfully!"
      redirect_to users_path
    else
      redirect_to edit_user_path,  alert: @user.errors.full_messages.to_sentence
    end
  end

  private

  def user_params
    params.expect(user: [ :username, :email, :password ])
  end
end
