class UsersController < ApplicationController
    def index
		  @userList = User.all 
    end
    


    def login

    end

    def post_login
    	if User.find_by(login: params[:login_name])
            @user = User.find_by(login: params[:login_name])
            if @user.password_valid?(params[:password])
    		  session[:user_id] = @user.id
              session[:first_name] = @user.first_name
    		  redirect_to(:controller => "photos", :action => "index", :id => @user.id)
            else
              flash[:notice] = "Password incorrect, please try again!"
              render(:action => :login)
            end
    	else
            flash[:notice] = "User not exist, please try again!"
    		render(:action => :login)
    	end
    end

    def logout
	    reset_session
    	redirect_to(:action => :login)
    end

    def new 
        @user = User.new

    end

    def user_params(params)
        return params.permit(:first_name, :last_name, :login, :password, :password_confirmation)
    end

    def create
        @user = User.new(user_params(params[:user]))
        if @user.save
            redirect_to(:action => "login")
        else 
            render(:action => :new)
        end
    end




    def search
        @photos = Photo.all
        @selected = []
        for photo in @photos do
            sel = false
            for comment in photo.comment do
                if comment.comment.downcase.include? params[:search].downcase
                    @selected.push(photo)
                    sel = true
                    break
                end
            end
            if !sel 
                for tag in photo.tag do
                    if User.find(tag.user_id).first_name.downcase.include?(params[:search].downcase) || User.find(tag.user_id).last_name.downcase.include?(params[:search].downcase)
                        @selected.push(photo)
                        break
                    end
                end
            end       
        end
        render :partial => "html_search"
    end
end