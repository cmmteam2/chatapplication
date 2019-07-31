class UserController < ApplicationController
    #before_action:logged_in_user, only:[:new, :show]
    def new
        logger.info "-----New------"

        a = "#{session[:fullpath]}"
        redirect_to "#{a}"
    end
    def create
        logger.info "-----Create------"
        user = User.new(name:params[:name],email:params[:email].downcase,password:params[:password])
        
        winvite = Workspaceinvite.find_by(email:user.email,confirm:"false")
        if params[:password] == params[:confirm_password]
        if user.save
=begin
            workspace = Workspace.new(name:"CyberMissions Myanmar",owner:user.id)
            workspace.save
            user.currentworkspace = workspace.id
            user.save
            uhw = UserHasWorkspace.new(user_id:user.id,workspace_id:workspace.id)
            uhw.save
            workspaces = Workspace.where(:owner => user.id)
            session[:workspaces] = workspaces
            session[:user] = user
            session[:user_id] = user.id
            session[:user_name] = user.name
            redirect_to "/"
=end
            session[:user] = user
            session[:user_id] = user.id
                            
            if winvite.nil? 
                redirect_to "/createworkspace"
            else
                if winvite.confirm == false
                    user.currentworkspace = winvite.workspace_id
                    userid = user.id
                    user.save
                    
                    winvite.confirm = true
                    winvite.save
                    u = User.find(session[:user]["id"])
                    session[:user] = u
                 
                    uhw = UsersWorkspace.new(user_id:userid,workspace_id:winvite.workspace_id)
                    uhw.save
                    currentworkspace = UsersWorkspace.find_by(user_id:session[:user]["id"])
                    
                    session[:usr_id] = userid
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
                else
                    
                end
                
                
            end
            
        else
            flash[:danger] = "notsuccessful"
            redirect_to "/"
        end
    else
        flash[:danger] = "pwdoesnotmatch"
        a = "#{session[:fullpath]}"
             redirect_to "#{a}"
    end
    end
    def show
        logger.info "-----Show #{params[:id]}------"
        @user = User.find(params[:id])
    end
    def uploadpic

        name = params[:file]
        bn = File.absolute_path("public/upload/#{params[:file]}")
        #bn = File.extname(name)
        require 'fileutils'
        #FileUtils.move "#{bn}", 'public/upload'
         
        #a = "C:/Users/CMM/Desktop/rails.jpg"
        #FileUtils.cp a, "public/upload/"
        render html:"#{a}"
=begin
        require 'fileutils'
        FileUtils.move "Chrysanthemum.jpg", 'public/'
        user = User.find(params[:userid])
        a = params[:picture]
        user.image = a
        user.save
        render html:"#{user.image}"

        if user.save
            render html:"successful #{user.picture}"
        else
            render html:"Not"
        end
        #render html:"#{params[:picture]} #{params[:userid]}"
=end
    end
    def destroy
       
        
        user = User.find(params[:id])
        user.destroy
        redirect_back fallback_location: root_path
       
    end
    def settingadmin
        logger.info "-----Setting Admin #{params[:email]}------"
        user = User.find(params[:adminid])
        user.role = "1"
        if user.save
            flash[:danger] = "successful"
            redirect_back fallback_location: root_path
        else

        end
    end
end
