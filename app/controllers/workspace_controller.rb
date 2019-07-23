class WorkspaceController < ApplicationController
    def index
        @workspace =  Workspace.all
    end
    def create
        w = Workspace.new(name:params[:name],owner:session[:user]["id"])
        
        w.save
        u = User.find(session[:user]["id"])
        u.currentworkspace = w.id
        u.save
        uhw = UsersWorkspace.new(user_id:session[:user]["id"],workspace_id:w.id)
        uhw.save
        currentworkspace = UsersWorkspace.find_by(user_id:session[:user]["id"])
        
        session[:currentworkspace] = currentworkspace.workspace.name
        session[:currentworkspace_id] = currentworkspace.workspace.id
        flash[:success] = "Successfully Created."

        @uhgs= GroupsUser.all
        @uhw = UsersWorkspace.where(:workspace_id => session[:user]["currentworkspace"])
        @group = Group.where(:workspace_id => session[:user]["currentworkspace"])
            
        @currentworkspace = UsersWorkspace.find_by(user_id: session[:user]["id"],workspace_id: session[:user]["currentworkspace"])
        
        session[:uhw] = @uhw
        redirect_to "/"
        
    end
    def edit
        @workspace = Workspace.find(params[:id])
    end
    def update
        w = Workspace.find(params[:id])
        w.name = params[:name]
        session[:currentworkspace] = w.name
        w.owner = session[:user]["id"]
        w.save
        redirect_to "/"
    end
    def destroy
        
       
        @workspace = Workspace.find(params[:id])
        @workspace.destroy
       
        
        session.delete(:user_id)
        session.delete(:user)
    
        
        redirect_to "/"

    end
end
