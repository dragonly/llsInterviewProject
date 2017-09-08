class SessionController < ApplicationController
  def create
    user = User.find_by(username: login_params[:username])
    if !user
      render :json => {
        :result => "fail",
        :error => "no such user"
      }
      return
    end
    if !user.authenticate(login_params[:password])
      render :json => {
        :result => "fail",
        :error => "password incorrect"
      }
      return
    end
    log_in(user)
    render :json => { :result => "success" }
  end

  def destroy
    log_out
  end

  private
  def login_params
    params.require(:user).permit(:username, :password)
  end
end
