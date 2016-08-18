class AffiliatesController < ApplicationController

  def index
    add_breadcrumb "Affiliates"
    @support_ticket = SupportTicket.new
  end


end