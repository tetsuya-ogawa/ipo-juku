class Api::V1::ImagesController < Admins::BaseController
  skip_before_action :verify_authenticity_token
  def create
    image = Image.new(file: params[:file])
    if image.save
      render json: { url: image.file_url }
    else
      render json: { err: image.errors }
    end
  end
end
