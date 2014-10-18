class TicketCommentsController < ApplicationController
  include JsonResourceActions

  def ticket
    Ticket.find_by!(uid: params[:ticket_id])
  end

  def resources
    ticket.comments
  end

  def resource_params
    params.require(:comment).permit(:body, :author_id, :author_type)
  end
end
