require_relative 'questions_database'

class QuestionLike
  attr_accessor :id, :question_id, :user_id
  def initialize(options = {})
    @id, @question_id, @user_id = options.values_at('id', 'question_id', 'user_id')
  end

  # Check for not found and return first
  def self.find_by_id(id)
    like_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = (?)
    SQL

    return nil if like_data.empty?
    QuestionLike.new(like_data.first)
  end

  def self.find_by_user_id(user_id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        user_id = (?)
    SQL

    likes.map{ |datum| QuestionLike.new(datum)}
  end

  def self.find_by_question_id(question_id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        question_id = (?)
    SQL

    likes.map{ |datum| QuestionLike.new(datum)}
  end

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_likes
      ON
        question_likes.user_id = users.id
      WHERE
        question_id = (?)
    SQL

    likers.map { |datum| User.new(datum) }
  end

  def self.num_likes_for_question_id(question_id)
    QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_id = (?)
    SQL
  end

  def self.liked_questions_for_user_id(user_id)
    liked_questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        user_id = (?)
    SQL

    liked_questions.map{|datum| Question.new(datum)}
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions
      ON
        questions.id = question_likes.question_id
      GROUP BY
        question_id
      ORDER BY
        COUNT(question_id) DESC
      LIMIT
        (?)
    SQL

    questions.map { |datum| Question.new(datum) }
  end
end
