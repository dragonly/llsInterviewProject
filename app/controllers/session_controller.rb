class SessionController < ApplicationController
  def create
    params.require(:username)
    params.require(:password)
    username = params["username"]
    password = params["password"]
    user = User.find_by(username: username)
    if !user
      render :json => {
        :result => "fail",
        :error => "no such user"
      }
      return
    end
    if !user.authenticate(password)
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
end
