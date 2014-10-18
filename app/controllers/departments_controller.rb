class DepartmentsController < ApplicationController
  include JsonResourceActions

  def resources
    Department.all
  end

  def resource_params
    params.require(:department).permit(:name)
  end
end
