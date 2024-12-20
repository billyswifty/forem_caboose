module Forem
  class ModerationController < Forem::ApplicationController
    before_action :ensure_moderator_or_admin

    helper 'forem/posts'

    # index
    def index
      @forem_posts = forum.posts.pending_review
      @topics = forum.topics.pending_review
    end

    def posts
      Forem::Post.moderate!(params[:posts] || [])
      flash[:notice] = t('forem.posts.moderation.success')
      redirect_to "/forums"
    end

    def topic
      if params[:topic]
        topic = forum.topics.find(params[:topic_id])
        topic.moderate!(params[:topic][:moderation_option])
        flash[:notice] = t("forem.topic.moderation.success")
      else
        flash[:error] = t("forem.topic.moderation.no_option_selected")
      end
      redirect_to "/forums"
    end

    private

    def forum
      @forum = Forem::Forum.find(params[:forum_id])
    end

    helper_method :forum

    def ensure_moderator_or_admin
      unless forem_admin? || forum.moderator?(forem_user)
        raise CanCan::AccessDenied
      end
    end

  end
end
