class SessionsController < ApplicationController
  respond_to :json

  def unauthenticated
    render json: { error: params[:error] }
  end
end
