class TicketsController < ApplicationController
  respond_to :json

  def show
    @ticket = Ticket.find_by! uid: params[:id]
    respond_with(@ticket)
  end

  def index
    @tickets = Ticket
      .limit(params[:limit] || 10)
      .offset(params[:offset] || 0)
    respond_with(@tickets)
  end

  def create
    @ticket = current_user.tickets.create(ticket_params)
    respond_with(@ticket)
  end

  def update
    @ticket = current_user.tickets.find_by!(uid: params[:id])
    @ticket.update ticket_params
    respond_with(@ticket)
  end

  private
    def current_user
      @current_user ||= super || Customer.find_or_create_by(customer_params)
    end

    def customer_params
      params.require(:customer).permit(:name, :email)
    end

    def ticket_params
      if current_user.is_a?(Admin) || current_user.is_a?(Staff)
        params.require(:ticket).permit(:subject, :body, :status_id, :department_id)
      else
        params.require(:ticket).permit(:subject, :body)
      end
    end
end
