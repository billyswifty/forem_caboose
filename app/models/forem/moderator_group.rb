module Forem
  class ModeratorGroup < ActiveRecord::Base
    belongs_to :forum, :inverse_of => :moderator_groups, optional: true
    belongs_to :group, optional: true

    # attr_accessible :group_id
  end
end
