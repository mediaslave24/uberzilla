class UsersController < ApplicationController
  include JsonResourceActions

  def resources
    User.all
  end

  def resource_params
    params.require(:user).permit(:name, :email, :type, :password)
  end
end
