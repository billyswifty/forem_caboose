require 'friendly_id'

module Forem
  class Category < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, :use => :slugged

    belongs_to :site, :class_name => "Caboose::Site"
    has_many :forums, :order => 'sort_order'
    validates :name, :presence => true
    attr_accessible :name, :site_id

    def to_s
      name
    end

  end
end
