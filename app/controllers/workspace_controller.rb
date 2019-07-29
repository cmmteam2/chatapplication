class WorkspaceController < ApplicationController
    def index
        logger.info "-----Index------"
        @workspace =  Workspace.all
    end
    def create
        logger.info "-----Create------"
        w = Workspace.new(name:params[:name],owner:session[:user]["id"])
        
        w.save
        u = User.find(session[:user]["id"])
        u.currentworkspace = w.id
        u.save
        u = User.find(session[:user]["id"])
        session[:user] = u
        uhw = UsersWorkspace.new(user_id:session[:user]["id"],workspace_id:w.id)
        uhw.save
        currentworkspace = UsersWorkspace.find_by(user_id:session[:user]["id"])
        session[:usr_id] = session[:user]["id"]
        session[:currentworkspace] = currentworkspace.workspace.name
        session[:currentworkspace_id] = currentworkspace.workspace.id
        session[:workspace_owner] = currentworkspace.workspace.owner
        flash[:success] = "Successfully Created."

        @uhgs= GroupsUser.all
        @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
        @group = Group.where(:workspace_id => session[:user]["currentworkspace"])
            
        @currentworkspace = UsersWorkspace.find_by(user_id: session[:user]["id"],workspace_id: session[:user]["currentworkspace"])
        
        session[:uhw] = @uhw
        a = "#{session[:fullpath]}"
        redirect_to "#{a}"
        
    end
    def edit
        logger.info "-----Edit #{params[:email]}------"
        @workspace = Workspace.find(params[:id])
    end
    def update
        logger.info "-----Update #{params[:id]}------"
        w = Workspace.find(params[:id])
        w.name = params[:name]
        session[:currentworkspace] = w.name
        w.owner = session[:user]["id"]
        w.save
        a = "#{session[:fullpath]}"
        redirect_to "#{a}"
    end
    def destroy
        logger.info "-----Destroy #{params[:id]}------"
        @workspace = Workspace.find(params[:id])
        @workspace.destroy

        session.delete(:user_id)
        session.delete(:user)
    
        a = "#{session[:fullpath]}"
        redirect_to "#{a}"

    end
    def invite
        logger.info "----- Invite #{params[:id]}------"

        if params[:email]
            wi = Workspaceinvite.new(email:params[:email],confirm:"false",workspace_id:session[:user]["currentworkspace"])
            if wi.save
                flash[:notice] =  "invitationalert"
                redirect_back fallback_location: root_path
            else
                flash[:notice] =  "notsuccessful"
                redirect_back fallback_location: root_path
            end
        else

        end
    end
    def confirm
    end
    def removeworkspacemember
        logger.info "-----Remove Workspacemember #{params[:id]}------"
        uhw = UsersWorkspace.find(params[:uhw_id])
        if uhw.destroy
            flash[:notice] =  "successfullydelete"
            redirect_back fallback_location: root_path
        end
    end
end
