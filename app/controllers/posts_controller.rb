class PostsController < ApplicationController
    before_action :find_post, only: [:show,:retrieve_messages,:create_message]

    def index 
        render json: Post.all
    end

    def retrieve_messages
        render json: @post.messages.order({ created_at: :desc })
    end

    def create_message
        @post.messages.create(message_params)
    end

    private

    def find_post
        @post = Post.find(params[:id])
    end

    def message_params
        params.require(:message).permit(:text,:user)
    end
end
