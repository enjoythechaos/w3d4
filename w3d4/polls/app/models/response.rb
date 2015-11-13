class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: "AnswerChoice"

  has_one :question,
    through: :answer_choice,
    source: :question


  def sibling_responses
    # 1 get the "parent" question
    # 2 get the responses to that question
    # 3 filter out self from siblings
    # if self.id
    result = self.question.responses.where(":id IS NULL OR responses.id != :id", id: self.id)
    # else
    #   result = self.question.responses
    # end
  end

  def respondent_has_not_already_answered_question
    !self.sibling_responses.where("responses.user_id = ? ", self.user_id).exists?
  end

end
