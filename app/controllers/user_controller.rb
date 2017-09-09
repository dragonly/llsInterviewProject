class UserController < ApplicationController
  def show
    user = User.find_by(username: params[:id])
    render :json => user
  end

  def create
    user = User.new(user_params)
    if not user.valid?
      render :json => {
        :result => "fail",
        :error => user.errors.full_messages
      }
      return
    end
    user_saved = user.save
    balance = Balance.create(amount: 0, user_id: user.id)
    if user_saved && balance
      render :json => { :result => "success" }
    else
      render :json => { :result => "fail" }
    end
  end

  private
  # strong parameters
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
