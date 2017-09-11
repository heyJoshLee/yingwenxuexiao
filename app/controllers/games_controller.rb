class GamesController < ApplicationController
  before_action :require_paid_membership


end