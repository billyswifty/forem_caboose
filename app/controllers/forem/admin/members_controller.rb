module Forem
  module Admin
    class MembersController < BaseController
      
      def add
        user = Forem.user_class.where(:id => params[:user_id]).first
        unless group.members.exists?(user.id)
          group.members << user
        end
        redirect_to [:admin, group]
      end

      def autocomplete
        users = Forem.user_class.where(:site_id => @site.id).forem_autocomplete(params[:term])
        users = users.map do |u|
          { :id => u.id, :identifier => u.send(Forem.autocomplete_field) }
        end
        render :json => users
      end

      def destroy
        user = Forem.user_class.where(:id => params[:id]).first
          if group.members.exists?(user.id)
            group.members.delete(user)
            flash[:notice] = t("forem.admin.groups.show.member_removed")
          else
            flash[:alert] = t("forem.admin.groups.show.no_member_to_remove")
          end
        redirect_to [:admin, group]
      end

      private

      def group
        @group ||= Forem::Group.find(params[:group_id])
      end
    end
  end
end
