module Forem
  class Subscription < ActiveRecord::Base
    belongs_to :topic
    belongs_to :subscriber, :class_name => Forem.user_class.to_s

    validates :subscriber_id, :presence => true

    attr_accessible :subscriber_id

    def send_notification(post_id)
    	Caboose.log("sending notification to user #{self.subscriber.id} about post #{post_id} on topic #{self.topic.id}...")
    	if Caboose::Site.where(:name => 'mycast').exists?
		    subscriber = Caboose::User.where(:id => self.subscriber.id).first
		    if subscriber && !subscriber.email.blank? && self.topic && Forem::Post.where(:id => post_id).exists?
		      if Rails.env.production?
		        MycastMailer.delay(:queue => 'general').forum_notification(subscriber, self.topic.id, post_id)
		      elsif subscriber.id == 30
		        MycastMailer.forum_notification(subscriber, self.topic.id, post_id).deliver
		      end
		    end
		  end
    end
    
  end
end
