class SessionsController < ApplicationController
  def unauthenticated
    respond_to do |f|
      f.json do
        render json: { error: params[:error] }
      end
    end
  end

  def create
    warden.authenticate!
    redirect_to root_path
  end

  def destroy
    warden.logout
    redirect_to root_path
  end
end
