class CommentsController < ApplicationController
	def new
	    if params[:id] && Photo.exists?(params[:id])
		  @photo = Photo.find(params[:id])
		  @comment = Comment.new
		end
	end

	def create

		@comment = Comment.new
		@comment.comment = params[:comment][:comment]
		@comment.photo_id = params[:id]
		@comment.user_id = session[:user_id] 
		@comment.date_time = DateTime.now
		if @comment.save
			redirect_to(:controller => "photos", :action => "index", :id => Photo.find(params[:id]).user_id)
		else 
			@photo = Photo.find(params[:id])
			render(:action => :new, :id => params[:id])
		end
	end
end
