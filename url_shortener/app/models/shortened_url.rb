class ShortenedUrl < ActiveRecord::Base
  include SecureRandom

  validates :long_url, :short_url, :submitter_id, presence: true
  validates :long_url, :short_url, uniqueness: true

  belongs_to :submitter,
    :class_name => 'User',
    :foreign_key => :submitter_id,
    :primary_key => :id

  has_many :visits,
    :class_name => 'Visit',
    :foreign_key => :shortened_url_id,
    :primary_key => :id

  has_many :visitors,
    :through => :visits,
    :source => :visitor

  def self.random_code
    code = SecureRandom::urlsafe_base64
    until ShortenedUrl.all.pluck(:short_url).none? { |url| url == code } # ShortenedUrl.exists? (:short_url => code)
      code = SecureRandom::urlsafe_base64
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(long_url: long_url, short_url: ShortenedUrl.random_code, submitter_id: user.id)
  end

  def num_clicks
    # nc = Visit.all.pluck(:shortened_url_id).inject(0) {|acc, url_id| acc += 1 if id == url_id }
    Visit.where(shortened_url_id: self.id).count
  end

  def num_uniques
    Visit.where(shortened_url_id: 1).select(:visitor_id)
  end
end
