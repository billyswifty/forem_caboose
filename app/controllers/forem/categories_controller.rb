module Forem
  class CategoriesController < Forem::ApplicationController
    helper 'forem/forums'
    load_and_authorize_resource :class => 'Forem::Category'

    def show
    	if defined?(@page) && defined?(@site)
        @page.seo_title = "#{@category.name} Forums on #{@site.description}"
      end
    end

  end
end