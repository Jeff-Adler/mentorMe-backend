class ConnectionsController < ApplicationController
    def create 
        connection = Connection.create(connection_params)
        render json: connection
    end
  
    private
  
    def connection_params
        params.require(:connection).permit(:mentee_id,:mentor_id)
    end
end
