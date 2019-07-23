class SessionController < ApplicationController
    def index
        
        if session[:user]
            @uhgs= GroupsUser.all
            @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
            @group = Group.where(:workspace_id => session[:user]["currentworkspace"])
            
            @currentworkspace = UsersWorkspace.find_by(user_id: session[:user]["id"],workspace_id: session[:user]["currentworkspace"])
        end
        if session[:usr_id]
            @myworkspaces = UsersWorkspace.where(:user_id =>session[:usr_id])
        end
        session[:fullpath] = request.protocol
        session[:fullpath] += request.host_with_port
        session[:fullpath] += request.fullpath
        render template:"home/index"
    end
    def login
        render template:"session/login"
    end
    def create
        user = User.find_by(email: params[:email].downcase)
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
                    session[:user_name] = user.name
                    session[:user]= user
                    #session[:uhw] = uhw
                    a = "#{session[:fullpath]}"
                    redirect_to "#{a}"
                else
                    render html:"Not success"
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
                redirect_to "/"
        end

    end
    def destroy
        session.delete(:user_id)
        session.delete(:user)
        redirect_to "/"
    end
end
