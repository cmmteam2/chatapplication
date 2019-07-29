class GroupController < ApplicationController
    def new
        logger.info "-----New------"
        @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
    end
    def create  
        logger.info "-----Create------"              
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
        logger.info "-----View #{params[:id]}------"
        if session[:user]            
            @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
            @group = Group.where(:workspace_id => session[:user]["currentworkspace"])
            @datalist_users = GroupsUser.where(:group_id=>params[:id])
            @gtm = Groupthreadmessage.all
        end

        @mygroup = Group.find(params[:id])
        @uhg = GroupsUser.where(:group_id => params[:id])
        @uhgs= GroupsUser.all
        @groupmessage = Groupmessage.where(:group_id => @mygroup.id)
    end
    def sendmessage
        logger.info "-----Send Message #{params[:id]}------"
        if params[:message] != ""
            gm = Groupmessage.new(group_id:params[:id],message:params[:message],user_id:session[:user]["id"],unread:"false",favourite:"false")
            gm.save
        end
        redirect_back fallback_location: root_path
    end
    def reply
        logger.info "-----Reply #{params[:id]}------"
        gtm = Groupthreadmessage.new(message:params[:message],groupmessage_id:params[:groupmessage_id],user_id:session[:user]["id"])
        gtm.save
        redirect_back fallback_location: root_path
    end
    def edit
        logger.info "-----Edit #{params[:email]}------"
        @mygroup = Group.find(params[:id])
        if session[:user]
            @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
            @uhg = GroupsUser.where(:group_id => params[:id])
            @group = Group.where(:workspace_id => session[:user]["currentworkspace"])
        end
    end
    def update
        logger.info "-----Update #{params[:id]}------"
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
        logger.info "-----Destroy #{params[:id]}------"
        @group = Group.find(params[:id])
        @group.destroy
       
        redirect_to "/"
      end
    def deletemember
        logger.info "-----DeleteMember #{params[:id]}------"
        uhg = GroupsUser.find(params[:id])
        name = uhg.user.name
        uhg.delete
        flash[:notice] = "removechannelmember"
        redirect_back fallback_location: root_path
    end
    def gostar
        logger.info "-----Gostar #{params[:id]}------"
        gm = Groupmessage.find(params[:star_id])
            if gm.favourite == false or gm.favourite.nil?
                gm.favourite = "true"
                gm.favouritebyuserid = session[:user]["id"]
            else
                gm.favourite = "false"
                gm.favouritebyuserid = "0"
            end
        gm.save
        redirect_back fallback_location: root_path
    end
    def deletemessage
        logger.info "-----DeleteMessage #{params[:id]}------"
        gm = Groupmessage.find(params[:id])
        gm.destroy
        redirect_back fallback_location: root_path
 end
    def invite
        logger.info "-----Invite #{params[:id]}------"
        @mygroup = Group.find(params[:id])
        if session[:user]
            @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
            @uhg = GroupsUser.where(:group_id => params[:id])
            @group = Group.where(:workspace_id => session[:user]["currentworkspace"])
        end
    end
end
