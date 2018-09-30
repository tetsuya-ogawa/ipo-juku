# frozen_string_literal: true
module MetaTagHelper
  def default_meta_tags
    {
        title: default_title,
        description: default_description,
        canonical: request.url,
        # og: {
        #     image: Settings.site_url + Settings.site.og.image,
        #     site_name: Settings.site.default.name,
        #     url: request.original_url,
        #     title: :title,
        #     description: :description,
        #     type: og_type,
        #     locale: 'ja_JP'
        # }
    }
  end

  def set_meta_title(object = nil) # rubocop:disable AccessorMethodName
    set_meta_tags(title: default_title(object))
  end

  def set_meta_description(object = nil) # rubocop:disable AccessorMethodName
    set_meta_tags(description: default_description(object))
  end

  def error_page_meta_tag
    set_meta_tags title: 'お探しのページは見つかりませんでした'
    set_meta_tags noindex: true, nofollow: true
    set_meta_tags canonical: nil
  end

  def set_canonical(path) # rubocop:disable AccessorMethodName
    set_meta_tags canonical: path
  end

  def disabled_canonical
    set_meta_tags canonical: nil
  end

  def no_index
    set_meta_tags noindex: true, nofollow: true
  end

  private

  def default_title(object = nil)
    return 'IPO塾' unless object
    return object + current_page if object.is_a? String
    object.decorate.meta_title + current_page
  end

  def default_description(object = nil)
    return 'IPO塾説明' unless object
    return object + current_page if object.is_a? String
    object.decorate.meta_description + current_page
  end

  def current_page
    params[:page].present? ? "(#{params[:page]}ページ目)" : ''
  end

  def og_type
    request.path_info == '/' ? 'website' : 'article'
  end
end