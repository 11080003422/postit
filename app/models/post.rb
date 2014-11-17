class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true, length: {minimum: 10}

  before_save :add_slug!

  def add_slug!
    potential_slug = self.title.parameterize
    obj = Post.find_by_slug(potential_slug)
    count = 2
    while obj != nil && obj != self
      potential_slug = add_appendix!(potential_slug, count)
      obj = Post.find_by_slug(potential_slug)
      count += 1
    end

    self.slug = potential_slug
  end

  def add_appendix!(potential_slug, count)
    slug_words = potential_slug.split('-')
    if slug_words[-1].to_i != 0
      slug_words = slug_words[0...-1] unless count == 2
    end

    potential_slug = slug_words.push(count).join('-')
  end

  def vote_sum
    self.votes_up - self.votes_down
  end

  def votes_up
    self.votes.where(vote: true).size
  end

  def votes_down
    self.votes.where(vote: false).size
  end

  def to_param
    self.slug
  end
end