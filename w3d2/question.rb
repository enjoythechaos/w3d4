require_relative 'questions_database'

class Question
  attr_accessor :id, :title, :body, :author_id
  def initialize(options = {})
    @id, @title, @body, @author_id = options.values_at('id', 'title', 'body', 'author_id')
  end
  # Check for not found and return first
  def self.find_by_id(id)
    question_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = (?)
    SQL

    return nil if question_data.empty?
    Question.new(question_data.first)
  end

  # Check for not found and return first
  def self.find_by_title(title)
    question_data = QuestionsDatabase.instance.execute(<<-SQL, title)
      SELECT
        *
      FROM
        questions
      WHERE
        title = (?)
    SQL

    return nil if question_data.empty?
    Question.new(question_data.first)
  end

  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = (?)
    SQL

    questions.map{ |datum| Question.new(datum) }
  end

  def author
    author = QuestionsDatabase.instance.execute(<<-SQL, @author_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = (?)
    SQL

    User.new(author)
  end

  def replies
    # replies = QuestionsDatabase.instance.execute(<<-SQL, @id)
    #   SELECT
    #     *
    #   FROM
    #     replies
    #   WHERE
    #     question_id = (?)
    # SQL
    #
    # replies.map { |datum| Reply.new(datum) }
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question(@id)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
        INSERT INTO
          questions (title, body, author_id)
        VALUES
          (?, ?, ?)
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id)
        UPDATE
          questions
        SET
          title = ?, body = ?, author_id = ?
        WHERE
          id = ?
      SQL
    end

    @id = QuestionsDatabase.instance.last_insert_row_id
  end
end
