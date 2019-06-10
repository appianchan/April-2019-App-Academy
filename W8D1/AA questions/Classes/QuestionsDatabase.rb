require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton


    def initialize 
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end

    # def self.open
    #     self.type_translation = true
    #     self.results_as_hash = true
    #     @database = SQLite3::Database.new('../questions.db')
    # end

    # def self.instance
    #     reset if @database.nil?
    #     return @database
    # end 

    # def self.reset
    #     'rm ../questions.db'
    #     'cat ../import_db.sql | sqlite3 ../questions.db'
    #     QuestionsDatabase.open
    # end

end
