class Admins::ArticlesController < Admins::BaseController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    if @article.save
      redirect_to admin_articles_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @article.attributes = article_params
    if @article.save
      redirect_to admin_articles_path
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end
end
