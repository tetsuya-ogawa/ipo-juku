class CompaniesController < ApplicationController
  def index
    @companies = Company.order_by_listed.eager_load(:industry, ipo_information: :market).page(params[:page]).per(20)
  end

  def show
    @company = Company.find_by!(code: params[:id])
  end
end
