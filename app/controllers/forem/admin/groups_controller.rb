module Forem
  module Admin
    class GroupsController < BaseController
      before_action :find_group, :only => [:show, :destroy]

      def index
        @groups = Forem::Group.where(:site_id => @site.id).all
      end

      def new
        @group = Forem::Group.new(:site_id => @site.id)
      end

      def create
        @group = Forem::Group.new(params[:group])
        @group.site_id = @site.id
        if @group.save
          flash[:notice] = t("forem.admin.group.created")
          redirect_to [:admin, @group]
        else
          flash[:alert] = t("forem.admin.group.not_created")
          render :new
        end
      end

      def destroy
        @group.destroy
        flash[:notice] = t("forem.admin.group.deleted")
        redirect_to admin_groups_path
      end

      private

        def find_group
          @group = Forem::Group.find(params[:id])
        end
    end
  end
end
