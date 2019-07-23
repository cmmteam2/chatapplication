class UserController < ApplicationController
    #before_action:logged_in_user, only:[:new, :show]
    def new
       redirect_to"/"
    end
    def create
       
        user = User.new(name:params[:name],email:params[:email].downcase,password:params[:password])
        
        
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
            redirect_to "/createworkspace"
        else
            render html:"NOT"
        end
    end
    def show
        @user = User.find(params[:id])
    end
    def uploadpic

        name = params[:file]
        bn = File.absolute_path("public/upload/#{params[:file]}")
        #bn = File.extname(name)
        require 'fileutils'
        #FileUtils.move "#{bn}", 'public/upload'
         
        a = "C:/Users/CMM/Desktop/rails.jpg"
        FileUtils.cp a, "public/upload/"
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
end
