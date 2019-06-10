require 'sqlite3'
require_relative '../loader.rb'

class QuestionFollow

    attr_accessor :question_id, :user_id
    attr_reader :id

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end

    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @question_id, @user_id)
        INSERT INTO
            question_follows (question_id, user_id)
        VALUES
            (?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @question_id, @user_id, @id)
        UPDATE 
            question_follows
        SET 
            question_id = ?, user_id = ?
        WHERE
            id = ?
        SQL
    end

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute('SELECT * FROM question_follows WHERE question_follows.id = ?',id) 
        QuestionFollow.new(data)
    end

    def self.followers_for_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT 
            *
        FROM 
            users
        JOIN
            question_follows ON question_follows.user_id = users.id 
        JOIN 
            questions ON questions.id = question_follows.question_id
        WHERE 
            questions.id = ?
        SQL
        data.map{|datum|User.new(datum)}
    end

    def self.followed_questions_for_user_id(user_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT 
            *
        FROM 
            questions
        JOIN
            question_follows ON question_follows.question_id = questions.id 
        JOIN 
            users ON questions_follows.user_id = users.id
        WHERE 
            users.id = ?
        SQL
        data.map{|datum|User.new(datum)}
    end

end