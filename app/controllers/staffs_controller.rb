class StaffsController < ApplicationController
  include JsonResourceActions

  def resources
    Staff.all
  end

  def resource_params
    params.require(:staff).permit(:name, :email, :type, :password, :department_id)
  end
end
