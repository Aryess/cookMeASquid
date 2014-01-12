class CommentsController < ApplicationController

	def new
	end

	def create
		@comment = current_user.comments.build(params[:comment])
		render 'new'
	end

	def edit
	end

	def update
	end

	def destroy
	end
end
