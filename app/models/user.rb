class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  before_save :add_slug!

  def add_slug!
    potential_slug = self.usernames.parameterize
    obj = User.find_by_slug(potential_slug)
    count = 2
    while obj != nil && obj != self
      potential_slug = add_appendix!(potential_slug, count)
      obj = User.find_by_slug(potential_slug)
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

  def to_param
    self.slug
  end
end