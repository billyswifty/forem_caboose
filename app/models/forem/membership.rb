module Forem
  class Membership < ActiveRecord::Base
    belongs_to :group, optional: true
    belongs_to :member, :class_name => Forem.user_class.to_s, optional: true

    # attr_accessible :member_id, :group_id
  end
end
