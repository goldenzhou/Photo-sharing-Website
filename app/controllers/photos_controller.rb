class PhotosController < ApplicationController
	def index
	    if params[:id] && User.exists?(params[:id])
          @user = User.find(params[:id])
        end
    end

    def new 
    	@photo = Photo.new
    end

    def create
    	if params[:photo]
    		File.open(Rails.root.join('app', 'assets', 'images', params[:photo][:photo].original_filename), 'wb') do |file|
    		file.write(params[:photo][:photo].read)
  			end
			@photo = Photo.new
			@photo.user_id = session[:user_id]
			@photo.file_name = params[:photo][:photo].original_filename
			@photo.date_time = DateTime.now
			@photo.save()
			redirect_to(:controller => "photos", :action => "index", :id => session[:user_id])
		else 
			@photo = Photo.new
			flash[:notice] = "Photo must not be empty!"
			render(:action => :new)
		end

    end

    def newTag
    	if params[:id] && Photo.exists?(params[:id])
    		@photo = Photo.find(params[:id])
    		@tag = Tag.new
    		@users = User.all
    	end
    end

    def createTag
    	@tag = Tag.new
		@tag.user_id = params[:tag][:user_id]
		@tag.photo_id = params[:id] 
		@tag.left = params[:tag][:left]
		@tag.top = params[:tag][:top]
		@tag.width = params[:tag][:width]
		@tag.height = params[:tag][:height]
		if @tag.save
			redirect_to(:controller => "photos", :action => "index", :id => Photo.find(params[:id]).user_id)
		else 
			@photo = Photo.find(params[:id])
			@tag = Tag.new
    		@users = User.all
    		flash[:notice] = "You must tag before submit!"
			render(:action => :newTag, :id => params[:id])
		end
    end
end
