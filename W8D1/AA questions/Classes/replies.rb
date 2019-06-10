require 'sqlite3'
require_relative '../loader.rb'

class Reply
    attr_accessor :body, :question_id, :author_id, :parent_reply_id
    attr_reader :id

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @author_id = options['author_id']
        @parent_reply_id = options['parent_reply_id']
        @body = options['body']
    end

    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @question_id, @author_id, @body, @parent_reply_id)
        INSERT INTO
            replies (question_id, author_id, body, parent_reply_id)
        VALUES
            (?, ?, ?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @question_id, @author_id, @parent_reply_id, @body, @id)
        UPDATE 
            replies
        SET 
            question_id = ?, author_id = ?, parent_reply_id = ?, body = ?
        WHERE
            id = ?
        SQL
    end

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute('SELECT * FROM replies WHERE replies .id = ?',id) 
        Reply.new(data)
    end

    def self.find_by_author_id(author_id)
        data = QuestionsDatabase.instance.execute(<<-SQL,author_id)
        SELECT
            *
        FROM 
            replies
        WHERE 
            author_id = ?
        SQL
        Reply.new(data)
    end

    def self.find_by_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL,question_id)
        SELECT
            *
        FROM 
            replies
        WHERE 
            question_id = ?
        SQL
        Reply.new(data)
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

    def question
        data = QuestionsDatabase.instance.execute(<<-SQL, @question_id)
        SELECT
            *
        FROM 
            questions
        WHERE 
            questions.id = ?
        SQL
        data.map{|datum|Question.new(datum)}
    end

    def parent_reply
        raise "no parent for this reply" if @parent_reply_id = NULL
        data = QuestionsDatabase.instance.execute(<<-SQL, @parent_reply_id)
        SELECT
            *
        FROM 
            replies
        WHERE 
            replies.id = ?
        SQL
        data.map{|datum|Reply.new(datum)}
    end

    def child_replies

        data = QuestionsDatabase.instance.execute(<<-SQL, @id)  
        SELECT
            *
        FROM 
            replies
        WHERE 
            replies.parent_reply_id  = ? 
        SQL
        data.map{|datum|Reply.new(datum)}
    end

end

