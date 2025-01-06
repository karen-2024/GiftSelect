class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags

  scope :merge_posts, -> (tags){ }

  validates :tagname, uniqueness: true, presence: true

  def self.search_posts_for(content, method)

    if method == 'perfect'
      tags = Tag.where(tagname: content)
    elsif method == 'forward'
      tags = Tag.where('tagname LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('tagname LIKE ?', '%' + content)
    else
      tags = Tag.where('tagname LIKE ?', '%' + content + '%')
    end

    return tags.inject(init = []) {|result, tag| result + tag.posts}

  end
end