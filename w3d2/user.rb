require_relative 'questions_database'

class User
  attr_accessor :id, :fname, :lname
  def initialize(options = {})
    @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
  end

  def self.find_by_id(id)
    user_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = (?)
    SQL

    return nil if user_data.empty?
    User.new(user_data.first)
  end

  def self.find_by_name(fname, lname)
    user_data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = (?) AND lname = (?)
    SQL

    return nil if user_data.empty?
    User.new(user_data.first)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollows.find_by_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    QuestionsDatabase.instance.execute(<<-SQL, @id)
        SELECT
          CAST(COUNT(DISTINCT(question_likes.id)) AS FLOAT) /
            CAST(COUNT(DISTINCT(questions.id)) AS FLOAT)
        FROM
          users
        JOIN
          questions ON users.id = questions.author_id
        LEFT OUTER JOIN
          question_likes ON questions.id = question_likes.question_id
        WHERE
          users.id = (?)
    SQL
  end

  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
        UPDATE
          users
        SET
          fname = ?, lname = ?
        WHERE
          id = ?
      SQL
    end

    @id = QuestionsDatabase.instance.last_insert_row_id
  end
end
