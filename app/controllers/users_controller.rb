class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      key_hash = KeyConverterService.new(user_params[:public_key]).convert
      @user.assign_attributes(public_key: key_hash[:public_key], public_key_hex: key_hash[:public_key_hex])

      if @user.save
        format.html { render partial: 'users/thank_you' }
      else
        format.html { render partial: 'users/error', locals: { errors: @user.errors.full_messages } }
      end

    rescue ArgumentError => e
      format.html { render partial: 'users/error', locals: { errors: ['The public_key seems to be in the wrong format. Submit it as hex or npub.', e.message] } }
    rescue KeyConverterService::PrivateKeyError => e
      format.html { render partial: 'users/error', locals: { errors: [e.message] } }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :public_key)
  end
end
