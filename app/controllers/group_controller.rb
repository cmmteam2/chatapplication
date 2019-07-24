class GroupController < ApplicationController
    def new
        @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
    end
    def create                
        g = Group.new(name:params[:name],workspace_id:session[:user]["currentworkspace"],owner:session[:user]["id"],types:params[:cbx_hidden])
        g.save
        invites = params[:invites].split(",")
        
        invites.each {|a|
            u = User.find_by(email:a)
            uhg = GroupsUser.new(user_id:u.id,group_id:g.id)
            uhg.save
        }
        
        redirect_to "/"
       
    end
    def view
        if session[:user]            
            @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
            @group = Group.where(:workspace_id => session[:user]["currentworkspace"])
            @datalist_users = GroupsUser.where(:group_id=>params[:id])
        end

        @mygroup = Group.find(params[:id])
        @uhg = GroupsUser.where(:group_id => params[:id])
        @uhgs= GroupsUser.all
        @groupmessage = Groupmessage.where(:group_id => @mygroup.id)
    end
    def sendmessage
        if params[:message] != ""
            gm = Groupmessage.new(group_id:params[:id],message:params[:message],user_id:session[:user]["id"],unread:"false",favourite:"false")
            gm.save
        end
        redirect_back fallback_location: root_path
    end
    def edit
        
        @mygroup = Group.find(params[:id])
        if session[:user]
            @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
            @uhg = GroupsUser.where(:group_id => params[:id])
            @group = Group.where(:workspace_id => session[:user]["currentworkspace"])
        end
    end
    def update
        
        g = Group.find(params[:id])
        g.types = params[:cbx_hidden]
        g.name = params[:name]
        g.save
        if params[:invites] != ""
            invites = params[:invites].split(",")
            
            invites.each {|a|
                u = User.find_by(email:a)
                uhg = GroupsUser.new(user_id:u.id,group_id:g.id)
                uhg.save
            }
        end 
        flash[:notice] =  "channelupdate"
        redirect_back fallback_location: root_path
    end
    def destroy
        @group = Group.find(params[:id])
        @group.destroy
       
        redirect_to "/"
      end
    def deletemember
        uhg = GroupsUser.find(params[:id])
        name = uhg.user.name
        uhg.delete
        flash[:notice] = "removechannelmember"
        redirect_back fallback_location: root_path
    end
    def gostar
        gm = Groupmessage.find(params[:star_id])
        gm.favourite = "true"
        gm.save
        redirect_back fallback_location: root_path
    end
    def deletemessage
        gm = Groupmessage.find(params[:id])
        gm.destroy
        redirect_back fallback_location: root_path
 end
    def invite
        
        @mygroup = Group.find(params[:id])
        if session[:user]
            @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
            @uhg = GroupsUser.where(:group_id => params[:id])
            @group = Group.where(:workspace_id => session[:user]["currentworkspace"])
        end
    end
end
