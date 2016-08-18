class Help::SupportTicketsController < ApplicationController

  def create
    @support_ticket = SupportTicket.new(support_ticket_params)
    if @support_ticket.save
      flash[:success] = "Your ticket has been sent. We will try to get back to you within 24 hours."
      session[:return_to] ||= request.referer
      redirect_to session.delete(:return_to)
    else
      flash.now[:danger] = "There was a problem and your ticket was not sent."
      redirect_to session.delete(:return_to)
    end
  end

  def support_ticket_params
    params.require(:support_ticket).permit!
  end


end