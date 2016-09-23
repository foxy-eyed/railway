class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket_and_check_owner, only: [:show, :destroy]

  def show
  end

  def buy
    @ticket = Ticket.new(train_id: params[:train_id],
                         start_station_id: params[:start_station_id],
                         end_station_id: params[:end_station_id])
  end

  def create
    @ticket = current_user.tickets.new(ticket_params)

    if @ticket.save
      redirect_to @ticket, notice: 'Thank you for your order!'
    else
      render :buy
    end
  end

  def destroy
    @ticket.destroy
    redirect_to my_tickets_path, notice: 'Ticket was successfully deleted.'
  end

  def my
    @tickets = current_user.tickets
  end

  private

  def set_ticket_and_check_owner
    @ticket = Ticket.find(params[:id])
    redirect_to my_tickets_path, alert: 'Permission denied' unless @ticket.user == current_user
  end

  def ticket_params
    params.require(:ticket).permit(:train_id, :start_station_id, :end_station_id, :passenger_name, :passport_number)
  end
end
