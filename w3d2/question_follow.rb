require_relative 'questions_database'

class QuestionFollow
  attr_accessor :id, :question_id, :user_id
  def initialize(options = {})
    @id, @question_id, @user_id = options.values_at('id', 'question_id', 'user_id')
  end

  # Check for not found and return first
  def self.find_by_id(id)
    follow_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = (?)
    SQL

    return nil if follow_data.empty?
    QuestionFollow.new(follow_data.first)
  end

  def self.find_by_user_id(user_id)
    follows = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        user_id = (?)
    SQL

    follows.map{ |datum| QuestionFollow.new(datum) }
  end

  # Check for not found and return first
  def self.find_by_question_id(question_id)
    follow_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        question_id = (?)
    SQL
    return nil if follow_data.empty?
    QuestionFollow.new(follow_data.first)
  end

  def self.followers_for_question(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_follows
      JOIN
        users ON users.id = question_follows.user_id
      WHERE
        question_id = (?)
    SQL

    followers.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    followed = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions ON questions.id = question_follows.question_id
      WHERE
        user_id = (?)
    SQL

    followed.map { |datum| Question.new(datum) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions
      ON
        questions.id = question_follows.question_id
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
