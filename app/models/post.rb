class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true, length: {minimum: 10}

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