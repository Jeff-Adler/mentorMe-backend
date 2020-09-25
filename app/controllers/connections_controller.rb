class ConnectionsController < ApplicationController

    def create 
        connection = Connection.create(connection_params)
        render json: connection
    end
  
    private
  
    def connection_params
        params.require(:connection).permit(:mentee_id,:mentor_id,:mentor_type)
    end

    def connection_accept_params
        params.require(:mentee_id,:mentor_id)
    end

end
