class Admin::Dashboard::AffiliatePaymentsController < AdminController

  before_filter :set_affiliate_payment, only: [:edit, :update, :pay]

  def index
    @payments = AffiliatePayment.all    
  end


  def update
    @affiliate_payment.update(affiliate_payment_params)
    flash[:success] = "Affiliate Payment was updated."
    redirect_to admin_dashboard_affiliate_payments_path
  end

  def pay
    @affiliate_payment.paid = true
    @affiliate_payment.paid_date = DateTime.now
    @affiliate_payment.save
    flash[:success] = "Affiliate Payment marked as paid."
    redirect_to admin_dashboard_affiliate_payments_path
  end


  private

  def affiliate_payment_params
    params.require(:affiliate_payment).permit!
  end

  def set_affiliate_payment
    @affiliate_payment = AffiliatePayment.find_by(slug: params[:id])
  end


end
