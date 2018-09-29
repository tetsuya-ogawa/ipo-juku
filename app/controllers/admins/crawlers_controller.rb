class Admins::CrawlersController < Admins::BaseController
  def index
  end

  def create
    CrawlDataImporter.new(CrawlDataShaper.new.exec).exec
    redirect_to admin_crawlers_path
  end
end
