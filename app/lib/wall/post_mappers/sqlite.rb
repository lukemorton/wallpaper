require 'sqlite3'

module Wall
  module PostMappers
    class SQLite
      def db_path()
        File.dirname(__FILE__) + '/../../../app.db'
      end

      def db()
        @db ||= SQLite3::Database.new(db_path)
      end

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