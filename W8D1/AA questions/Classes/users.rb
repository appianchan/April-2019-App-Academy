require 'sqlite3'
require_relative '../loader.rb'
require 'byebug'

class User
    attr_accessor :fname, :lname
    attr_reader :id

    def self.all
        users = QuestionsDatabase.instance.execute('SELECT * FROM users')
        users.map{|user|User.new(user)}
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO
            users (fname,lname)
        VALUES
            (?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless @id #where does this id come from? 
        QuestionsDatabase.instance.execute(<<-SQL,@fname, @lname,@id)
        UPDATE 
            users 
        SET 
            fname = ?, lname = ?
        WHERE
            id = ? 
        SQL
    end


    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute('SELECT * FROM users WHERE users.id = ?',id) 
        Users.new(data)
    end

    def self.find_by_name(fname,lname)
        data = QuestionsDatabase.instance.execute(<<-SQL,fname,lname)
        SELECT 
            *
        FROM 
            users
        WHERE 
            fname = ? AND lname = ?
        SQL
        User.new(data[0])
    end

    def authored_questions
        data = QuestionsDatabase.instance.execute(<<-SQL, @id)
        SELECT 
            *
        FROM 
            questions
        WHERE 
            questions.author_id = ?
        SQL
        data.map{|datum|Question.new(datum)}
    end

    def authored_replies
        data = QuestionsDatabase.instance.execute(<<-SQL, @id)
        SELECT 
            *
        FROM 
            replies
        WHERE 
            replies.author_id = ?
        SQL
        data.map{|datum|Question.new(datum)}
    end

end