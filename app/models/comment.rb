class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post
  has_many :votes, as: :voteable

  validates :body, presence: true, length: {minimum: 5}

  def vote_sum
    votes_up - votes_down
  end

  def votes_up
    self.votes.where(vote: true).size
  end

  def votes_down
    self.votes.where(vote: false).size
  end
end