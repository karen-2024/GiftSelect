class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :post

  with_options presence: true do
    validates :comment
  end

end
