require_relative 'questions_database'

class Reply
  attr_accessor :id, :question_id, :parent_reply_id, :user_id, :body
  def initialize(options = {})
    @id, @question_id, @parent_reply_id, @user_id, @body =
      options.values_at('id', 'question_id', 'parent_reply_id', 'user_id', 'body')
  end

  # Check for not found and return first
  def self.find_by_id(id)
    reply_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = (?)
    SQL

    return nil if reply_data.empty?
    Reply.new(reply_data.first)
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = (?)
    SQL

    replies.map{ |datum| Reply.new(datum) }
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = (?)
    SQL

    replies.map{ |datum| Reply.new(datum) }
  end

  def self.find_by_parent_reply_id(parent_reply_id)
    reply_data = QuestionsDatabase.instance.execute(<<-SQL, parent_reply_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = (?)
    SQL

    reply_data.map { |datum| Reply.new(datum) }
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    Reply.find_by_parent_reply_id(@id)
  end

  def save

    temp_parent_reply_id = @parent_reply_id ? @parent_reply_id : 'NULL'

    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, @question_id, temp_parent_reply_id, @user_id, @body)
        INSERT INTO
          replies (question_id, parent_reply_id, user_id, body)
        VALUES
          (?, ?, ?, ?)
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_reply_id, @user_id, @body, @id)
        UPDATE
          replies
        SET
          question_id = ?, parent_reply_id = ?, user_id = ?, body = ?
        WHERE
          id = ?
      SQL
    end

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

end
