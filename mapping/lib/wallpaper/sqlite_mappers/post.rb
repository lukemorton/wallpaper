require 'sqlite3'
require_relative 'sqlite_mapper'

module Wallpaper
  module SQLiteMappers
    class Post < SQLiteMapper
      def create_table!()
        db.execute('CREATE TABLE IF NOT EXISTS posts (content VARCHAR(255), created INTEGER);')
      end

      def find_latest()
        posts = []

        db.execute('SELECT content FROM posts ORDER BY created DESC') do |row|
          posts << {:content => row[0]}
        end

        return posts
      end

      def create(post)
        data = [post[:content], Time.now.to_i]
        db.execute('INSERT INTO posts VALUES (?, ?)', data)
      end
    end
  end
end
