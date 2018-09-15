class CompaniesController < ApplicationController
  def index
    @companies = Company.order_by_listed
  end

  def show
  end
end
