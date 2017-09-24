class Admin::Dashboard::AffiliatesController < AdminController

  before_action :set_affiliate, only: [:show, :update, :edit]

  def index
    add_breadcrumb "Affiliates", admin_dashboard_affiliates_path
    @affiliates = Affiliate.all
  end

  def new
    @affiliate = Affiliate.new
  end

  def create
    @affiliate = Affiliate.new(affiliate_params)
    if @affiliate.save
      flash[:success] = "affiliate was saved"
      redirect_to admin_dashboard_affiliate_path(@affiliate)
    else
      flash.now[:danger] = "There was a problem and the affiliate was not saved"
      render :new
    end
  end

  def edit
  end

  def show
    add_breadcrumb "Affiliates", admin_dashboard_affiliates_path
    add_breadcrumb @affiliate.name, admin_dashboard_affiliate_path(@affiliate)
  end

  def update
    if @affiliate.update(@affiliate_params)
      flash[:success] = "affiliate was saved"
      redirect_to edit_admin_dashboard_affiliate_path(@affiliate)
    else
      flash.now[:danger] = "There was a problem and the affiliate was not saved"
      render :edit
    end
  end

  private

  def set_affiliate
    @affiliate = Affiliate.find_by(slug: params[:id])
  end

  def affiliate_params
    params.require(:affiliate).permit!
  end

end