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
    @ticket = current_customer.tickets.create(ticket_params)
    respond_with(@ticket)
  end

  def update
    @ticket = tickets.find_by!(uid: params[:id])
    @ticket.update ticket_params
    respond_with(@ticket)
  end

  def changelog
    @ticket = tickets.find_by!(uid: params[:id])
    respond_with(@ticket.changelog)
  end

  def destroy
    @ticket = tickets.find_by!(uid: params[:id])
    @ticket.destroy
    respond_with(@ticket)
  end

  private
    def current_customer
      @current_customer ||= current_user || Customer.find_or_create_by(customer_params)
    end

    def customer_params
      params.require(:customer).permit(:name, :email)
    end

    def ticket_params
      if current_user.is_a?(Customer)
        params.require(:ticket).permit(:subject, :body)
      else
        params.require(:ticket).permit(:subject, :body, :staff_id, :staff_type, :status_id, :department_id)
      end
    end

    def tickets
      if current_user.is_a?(Customer)
        current_user.tickets
      else
        Ticket.all
      end.includes(:customer, :status, :staff)
    end
end
