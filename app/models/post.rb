class Post < ApplicationRecord
  belongs_to :connection

  # def self.map_posts_from_connections(connections)  
  #     filteredConnections = connections.select do |connection|
  #       connection.post != nil
  #     end

  #     filteredConnections.map do |connection|
  #         connection.post
  #     end
  # end

  def self.map_posts_from_connections(connections)
    filteredConnections = connections.select do |connection|
      connection.post != nil
    end

    filteredConnections.map do |connection|
      [
        {post: connection.post},
        {connection: connection},
        {mentee: connection.mentee},
        {mentor: connection.mentor}
      ]
    end
  end
end