class Article < ApplicationRecord
  mount_uploader :main_image, ImageUploader
  mount_uploader :thumbnail, ImageUploader
end
