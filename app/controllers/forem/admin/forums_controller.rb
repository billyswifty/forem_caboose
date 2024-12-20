module Forem
  module Admin
    class ForumsController < BaseController
      before_action :find_forum, :only => [:edit, :update, :destroy]

      def index
        @forums = Forem::Forum.where(:site_id => @site.id).all
      end

      def new
        @forum = Forem::Forum.new
      end

      def create
        @forum = Forem::Forum.new(params[:forum])
        @forum.site_id = @site.id
        if @forum.save
          create_successful
        else
          create_failed
        end
      end

      def update
        if @forum.update_attributes(params[:forum])
          update_successful
        else
          update_failed
        end
      end

      def destroy
        @forum.destroy
        destroy_successful
      end

      private

      def find_forum
        @forum = Forem::Forum.find(params[:id])
      end

      def create_successful
        flash[:notice] = t("forem.admin.forum.created")
        redirect_to admin_forums_path
      end

      def create_failed
        flash.now.alert = t("forem.admin.forum.not_created")
        render :action => "new"
      end

      def destroy_successful
        flash[:notice] = t("forem.admin.forum.deleted")
        redirect_to admin_forums_path
      end

      def update_successful
        flash[:notice] = t("forem.admin.forum.updated")
        redirect_to admin_forums_path
      end

      def update_failed
        flash.now.alert = t("forem.admin.forum.not_updated")
        render :action => "edit"
      end

    end
  end
end
