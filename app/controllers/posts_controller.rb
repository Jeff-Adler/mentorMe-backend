class PostsController < ApplicationController

    def index 
        #Return:
        # Post.mentor
        # Post.mentee
        # @post.connection.mentor/mentee works!
        render json: Post.all
    end
end
