class MessagesController < ApplicationController
    def create 
        message = Message.create!(post_id: params[:post_id], user_id: params[:user_id])
        message.assign_attributes(text: message_params[:text])
        message.assign_attributes(message_created_at: message_params[:createdAt])
        message.save
        if message.valid?
            render json: message
        else
            render json: {error: "Couldn't store message!"}
        end
    end

    private 

    def message_params
        params.require(:message).permit(:createdAt,:text)
    end
end
