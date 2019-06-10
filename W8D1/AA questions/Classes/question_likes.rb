require 'sqlite3'
require_relative '../loader.rb'

class QuestionLike
    attr_accessor :question_id, :liker_id
    attr_reader :id

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @liker_id = options['liker_id']
    end

    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @question_id, @liker_id)
        INSERT INTO
            question_likes (question_id, liker_id)
        VALUES
            (?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @question_id, @user_id, @id)
        UPDATE 
            question_likes
        SET 
            question_id = ?, liker_id = ?
        WHERE
            id = ?
        SQL
    end

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute('SELECT * FROM question_likes WHERE question_likes.id = ?',id) 
        QuestionLikes.new(data)
    end

end