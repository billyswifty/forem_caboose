module Forem
  class View < ActiveRecord::Base
    before_create :set_viewed_at_to_now

    belongs_to :viewable, :polymorphic => true, optional: true
    belongs_to :user, :class_name => Forem.user_class.to_s, optional: true

    validates :viewable_id, :viewable_type, :presence => true
    # attr_accessible :user, :current_viewed_at, :count

    def viewed_at
      updated_at
    end

    private
    def set_viewed_at_to_now
      self.current_viewed_at = Time.now
      self.past_viewed_at = current_viewed_at
    end
  end
end
