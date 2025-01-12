class Post < ApplicationRecord

  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  belongs_to :user

  with_options presence: true do
    validates :image
    validates :name
    validates :introduction
    validates :amount
    validates :package
    validates :price
    validates :prefecture
    validates :location
    validates :recommend
    validates :review
    validates :star
  end

  #都道府県
  enum prefecture: {北海道: 0, 青森県: 1, 岩手県: 2, 宮城県: 3, 秋田県: 4, 山形県: 5, 福島県: 6, 
                    茨城県: 7, 栃木県: 8, 群馬県: 9, 埼玉県: 10, 千葉県: 11, 東京都: 12, 神奈川県: 13, 
                    新潟県: 14, 富山県: 15, 石川県: 16, 福井県: 17, 山梨県: 18, 長野県: 19, 岐阜県: 20, 
                    静岡県: 21, 愛知県: 22, 三重県: 23, 滋賀県: 24, 京都府: 25, 大阪府: 26, 兵庫県: 27, 
                    奈良県: 28, 和歌山県: 29, 鳥取県: 30, 島根県: 31, 岡山県: 32, 広島県: 33, 山口県: 34, 
                    徳島県: 35, 香川県: 36, 愛媛県: 37, 高知県: 38, 福岡県: 39, 佐賀県: 40, 長崎県: 41,
                    熊本県: 42, 大分県: 43, 宮崎県: 44, 鹿児島県: 45, 沖縄県: 46, 海外: 47, その他: 48}

  #オススメ
  enum recommend: {上司・取引先の方へ: 0, 同僚・親しい人へ: 1, 多人数いる職場の方へ: 2, お世話になっている方へ: 3,
                  友達・家族へ: 4, 自分へのご褒美に！: 5, 迷ったらコレ！（定番）: 6, 限定品！！: 7, ちょっと珍しいモノ！: 8}

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def save_tags(tags)
    current_tags = self.tags.pluck(:tagname) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_tagname|
      self.tags.delete Tag.find_by(tagname:old_tagname)
    end

    new_tags.each do |new_tagname|
      tag = Tag.find_or_create_by(tagname:new_tagname)
      self.tags << tag
    end
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(name: content)
    elsif method == 'forward'
      Post.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('name LIKE ?', '%' + content)
    else
      Post.where('name LIKE ?', '%' + content + '%')
    end
  end

end
