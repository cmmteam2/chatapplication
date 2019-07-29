class SessionController < ApplicationController
    def index
        
        if session[:user]
            if params[:abc]
                @favouritemsgs = Groupmessage.where("favourite = ? AND favouritebyuserid = ?", true, session[:user]["id"])
                @isadmin = User.find_by(role:"1")
                @users = User.page(params[:abc]).per(4)
                @groups = Group.all
                @workspaces = Workspace.all
                @uhgs= GroupsUser.all
                @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
                @group = Group.where(:workspace_id => session[:user]["currentworkspace"])
                
                @currentworkspace = UsersWorkspace.find_by(user_id: session[:user]["id"],workspace_id: session[:user]["currentworkspace"])
                if session[:usr_id]
                    @myworkspaces = UsersWorkspace.where(:user_id =>session[:usr_id])
                end
                session[:fullpath] = request.protocol
                session[:fullpath] += request.host_with_port
                session[:fullpath] += request.fullpath
                session[:lan] = request.fullpath
                render template:"home/index"
            else
                @favouritemsgs = Groupmessage.where("favourite = ? AND favouritebyuserid = ?", true, session[:user]["id"])
                @isadmin = User.find_by(role:"1")
                @users = User.page(1).per(4)
                @groups = Group.all
                @workspaces = Workspace.all
                @uhgs= GroupsUser.all
                @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
                @group = Group.where(:workspace_id => session[:user]["currentworkspace"])
                
                @currentworkspace = UsersWorkspace.find_by(user_id: session[:user]["id"],workspace_id: session[:user]["currentworkspace"])
                if session[:usr_id]
                    @myworkspaces = UsersWorkspace.where(:user_id =>session[:usr_id])
                end
                session[:fullpath] = request.protocol
                session[:fullpath] += request.host_with_port
                session[:fullpath] += request.fullpath
                session[:lan] = request.fullpath
                render template:"home/index"
            end
           
        else
                @isadmin = User.find_by(role:"1")
                @users = User.all
                @groups = Group.all
                @workspaces = Workspace.all
                @uhgs= GroupsUser.all
                
                if session[:usr_id]
                    @myworkspaces = UsersWorkspace.where(:user_id =>session[:usr_id])
                end
                render template:"home/index"
        end
        
    end
    def login
        render template:"session/login"
    end
    def create
        user = User.find_by(email: params[:email].downcase)
        if user.nil?
                wi = Workspaceinvite.find_by(email:params[:email].downcase,confirm:"false")
                if wi.nil?
                    flash[:danger] = "emailnotfound"
                    redirect_back fallback_location: root_path
                else
                   session[:inviteemail] = params[:email]
                    redirect_to controller: 'workspace', action: 'confirm'
                end
        else
                workspaces = Workspace.where(:owner => user.id)
                currentworkspace = UsersWorkspace.find_by(user_id:user.id,workspace_id:user.currentworkspace)
                if currentworkspace.nil?
                        render template:"workspace/new"
                        session[:user]= user
                        
                        session[:user_id] = user.id
                    else
                        user.currentworkspace = currentworkspace.workspace_id
                        user.save
                        if user && user.authenticate(params[:password])
                            #userhw = Userhasworkspace.find_by(user_id:user.id)
                            #user.currentworkspace = userhw.workspace_id
                            #user.save  
                            
                            #uhw = Userhasworkspace.where(:workspace_id=> user.currentworkspace)
                            session[:currentworkspace] = currentworkspace.workspace.name
                            session[:currentworkspace_id] = currentworkspace.workspace.id
                            session[:workspace_owner] = currentworkspace.workspace.owner
                            session[:workspaces] = workspaces
                            session[:user_id] = user.id
                            session[:usr_id] = user.id
                            session[:user]= user
                            #session[:uhw] = uhw
                            a = "#{session[:fullpath]}"
                            redirect_to "#{a}"
                        else
                            flash[:danger] = "passwordinvalid"
                            redirect_back fallback_location: root_path
                        end
                    end
                
            end
        

    end
    def loginworkspace
        user = User.find(session[:usr_id])
        uhw = UsersWorkspace.find(params[:id])
        user.currentworkspace = uhw.workspace_id
        user.save
        
        user = User.find(session[:usr_id])
        workspaces = Workspace.where(:owner => user.id)
        currentworkspace = UsersWorkspace.find_by(user_id:user.id,workspace_id:user.currentworkspace)
        if currentworkspace.nil?
            render template:"workspace/new"
        else
                session[:currentworkspace] = currentworkspace.workspace.name
                session[:workspace_owner] = currentworkspace.workspace.owner
                session[:workspaces] = workspaces
                session[:user_id] = user.id
                session[:usr_id] = user.id
                session[:user_name] = user.name
                session[:user]= user
                redirect_to "#{session[:fullpath]}"
        end

    end
    def destroy
        session.delete(:user_id)
        session.delete(:user)
        redirect_to "/"
    end
end
