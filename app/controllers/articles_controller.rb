class ArticlesController < ApplicationController
  def index
    @companies = Article.all.page(params[:page]).per(20)
  end

  def show
    @company = Article.find(params[:id])
  end
end
