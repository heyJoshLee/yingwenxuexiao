class Admin::Dashboard::AffiliateLinksController < ApplicationController

  before_action :set_affilate_link, only: [:show, :update, :edit]
  before_action :set_affiliate, only: [:create]
  
  def new
    @affiliate_link = AffiliateLink.new
  end

  def create
    @affiliate_link = @affiliate.affiliate_links.build(affiliate_link_params)
    @affiliate_link.generate_random_slug
    @affiliate_link.url = request.domain + sign_up_path.to_s + "?affiliate_signup_code=" + @affiliate_link.slug
    if @affiliate_link.save
      flash[:success] = "affiliate_link was saved"
      redirect_to admin_dashboard_affiliate_path(@affiliate)
    else
      flash.now[:danger] = "There was a problem and the affiliate_link was not saved"
      render :new
    end
  end

  def edit
  end

  def update
    if @affiliate_link.update(@affiliate_link_params)
      flash[:success] = "affiliate_link was saved"
      redirect_to affiliate_link_path(@affiliate_link)
    else
      flash.now[:danger] = "There was a problem and the affiliate_link was not saved"
      render :edit
    end
  end

  private

  def set_affiliate_link
    @affiliate_link = AffiliateLink.find_by(slug: params[:id])
  end

  def set_affiliate
    @affiliate = Affiliate.find_by(slug: params[:affiliate_id])
  end

  def affiliate_link_params
    params.require(:affiliate_link).permit!
  end

end