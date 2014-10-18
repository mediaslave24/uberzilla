class SessionsController < ApplicationController
  def unauthenticated
    redirect_to root_path, alert: 'Wrong password'
  end

  def create
    authenticate! :password
    redirect_to root_path
  end

  def destroy
    logout
    redirect_to root_path
  end
end
