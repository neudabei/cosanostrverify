class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { render partial: 'users/thank_you' }
      else
        format.html { render partial: 'users/error', locals: { errors: @user.errors.full_messages } }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :public_key)
  end
end
