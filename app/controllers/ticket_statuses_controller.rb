class TicketStatusesController < ApplicationController
  include JsonResourceActions

  def resources
    TicketStatus.all
  end

  def resource_params
    params.require(:ticket_status).permit(:name, :default)
  end
end
