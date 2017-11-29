module Forem
  class Group < ActiveRecord::Base
    validates :name, :presence => true

    has_many :memberships
    has_many :members, :through => :memberships, :class_name => Forem.user_class.to_s
    belongs_to :site, :class_name => "Caboose::Site"

    attr_accessible :name, :site_id

    def to_s
      name
    end
  end
end
