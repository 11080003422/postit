class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, length: {minimum: 3}

  before_save :add_slug!

  def add_slug!
    potential_slug = self.name.parameterize
    obj = Category.find_by_slug(potential_slug)
    count = 2
    while obj != nil && obj != self
      potential_slug = add_appendix!(potential_slug, count)
      obj = Category.find_by_slug(potential_slug)
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