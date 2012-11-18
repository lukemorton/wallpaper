require 'sqlite3'

module Wallpaper
  module SQLiteMappers
    class SQLiteMapper
      def initialize(db_path)
        @db_path = db_path
      end

    private

      attr_reader :db_path

      def db()
        @db ||= SQLite3::Database.new(db_path)
      end
    end
  end
end
