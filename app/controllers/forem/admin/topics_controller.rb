module Forem
  module Admin
    class TopicsController < BaseController
      before_action :find_topic

      def update
        if @topic.update_attributes(params[:topic], :as => :admin)
          flash[:notice] = t("forem.topic.updated")
          redirect_to forum_topic_path(@topic.forum, @topic)
        else
          flash.alert = t("forem.topic.not_updated")
          render :action => "edit"
        end
      end

      def destroy
        forum = @topic.forum
        @topic.destroy
        flash[:notice] = t("forem.topic.deleted")
        redirect_to forum_topics_path(forum)
      end

      def toggle_hide
        @topic.toggle!(:hidden)
        flash[:notice] = t("forem.topic.hidden.#{@topic.hidden?}")
        redirect_to forum_topic_path(@topic.forum, @topic)
      end

      def toggle_lock
        @topic.toggle!(:locked)
        flash[:notice] = t("forem.topic.locked.#{@topic.locked?}")
        redirect_to forum_topic_path(@topic.forum, @topic)
      end

      def toggle_pin
        @topic.toggle!(:pinned)
        flash[:notice] = t("forem.topic.pinned.#{@topic.pinned?}")
        redirect_to forum_topic_path(@topic.forum, @topic)
      end

      private
        def find_topic
          @topic = Forem::Topic.find(params[:id])
        end
    end
  end
end
