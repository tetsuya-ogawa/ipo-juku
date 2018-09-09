class Admins::CrawlersController < Admins::BaseController
  def index
  end

  def create
    CrawlDataImporter.new(CrawlDataShaper.new.exec).exec
  end
end
