class Post < ApplicationRecord
  belongs_to :connection

  def self.map_posts_from_connections(connections)
      connections.map do |connection|
          connection.post
      end
  end
end
