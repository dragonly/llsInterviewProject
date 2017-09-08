class UserController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show
    @user = User.find_by(username: params[:id])
    render :json => @user
  end

  def create
    @user = User.new(user_params)
    if not @user.valid?
      render :json => {
        :result => "fail",
        :error => @user.errors.full_messages
      }.to_json
      return
    end
    if @user.save
      render :json => { :result => "success" }.to_json
    else
      render :json => { :result => "fail" }.to_json
    end
  end

  private
  # strong parameters
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
