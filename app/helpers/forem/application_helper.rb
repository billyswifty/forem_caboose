module Forem
  module ApplicationHelper
    include FormattingHelper

    # processes text with installed markup formatter
    def forem_format(text, *options)
      return "" if text.blank?
      txt = text.gsub("\n","<br />")
      bad_words = ["fuck","nigger","shit","cunt","asshole","bitch"]
      bad_words.each do |bw|
        st = bw.chars.map{|c| "*"}.join("")
        txt = txt.gsub(bw,st).gsub(bw.upcase,st).gsub(bw.titleize,st)
      end
      begin
        txt = Rinku.auto_link(txt, mode=:all, link_attr='target="_blank" rel="ugc"', skip_tags=nil)
        txt = txt.gsub("<a ",'<a rel="ugc"')
        return txt
      rescue
        return txt
      end
    end

    def forem_quote(text)
      as_quoted_text(text)
    end

    def forem_markdown(text, *options)
      Rails.logger.warn("DEPRECATION: forem_markdown is replaced by forem_format() + forem-markdown_formatter gem, and will be removed")
      forem_format(text)
    end

    def forem_pages_widget(collection, options={})
      if collection.num_pages > 1
        content_tag :div, :class => 'pages' do
          (forem_paginate(collection, options)).html_safe
        end
      end
    end

    def forem_paginate(collection, options={})
      if respond_to?(:will_paginate)
        # If parent app is using Will Paginate, we need to use it also
        will_paginate collection, options
      else
        # Otherwise use Kaminari
        paginate collection #, options
      end
    end

    def forem_atom_auto_discovery_link_tag
      if controller_name == "topics" && action_name == "show"
        auto_discovery_link_tag(:atom)
      end
    end

    def forem_emojify(content)

      return "" if content.blank?
      txt = h(content).to_str
      bad_words = ["fuck","nigger","shit","cunt","asshole","bitch"]
      bad_words.each do |bw|
        st = bw.chars.map{|c| "*"}.join("")
        txt = txt.gsub(bw,st).gsub(bw.upcase,st).gsub(bw.titleize,st)
      end

      return txt.html_safe

    end
  end
end