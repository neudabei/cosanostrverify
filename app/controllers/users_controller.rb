class UsersController < ApplicationController
  def new
    JsonCreatorService.new.write_json_file
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      key_hash = KeyConverterService.new(user_params[:public_key]).convert
      @user.assign_attributes(public_key: key_hash[:public_key], public_key_hex: key_hash[:public_key_hex])

      if @user.save
        JsonCreatorService.new.write_json_file

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
