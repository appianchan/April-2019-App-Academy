require 'sqlite3'
require_relative '../loader.rb'

class Question
    attr_accessor :body, :title, :author_id
    attr_reader :id

    def self.all
        questions = QuestionsDatabase.instance.execute('SELECT * FROM questions')
        questions.map{|question|Question.new(question)}
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
        INSERT INTO
            questions (title,body,author_id)
        VALUES
            (?, ?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless @id #where does this id come from? 
        QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id)
        UPDATE 
            questions   
        SET 
            title = ?, body = ?, author_id = ?
        WHERE
            id = ?
        SQL
    end


    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute('SELECT * FROM questions WHERE questions.id = ?',id) 
        Question.new(data)
    end

    def self.find_by_title(title)
        data = QuestionsDatabase.instance.execute(<<-SQL,title)
        SELECT 
            *
        FROM 
            questions
        WHERE 
            title = ?
        SQL
        Questions.new(data)
    end

    def self.find_by_author_id(author_id)
        data = QuestionsDatabase.instance.execute(<<-SQL,author_id)
        SELECT
            *
        FROM 
            questions
        WHERE 
            author_id = ?
        SQL
        Question.new(data)
    end

    def author
        data = QuestionsDatabase.instance.execute(<<-SQL, @author_id)
        SELECT 
            *
        FROM 
            users
        WHERE 
            users.id = ?
        SQL
        data.map{|datum|User.new(datum)}
    end

    def replies
        data = QuestionsDatabase.instance.execute(<<-SQL, @id)
        SELECT 
            *
        FROM 
            replies
        WHERE 
            replies.question_id = ?
        SQL
        data.map{|datum|Reply.new(datum)}
    end

end