class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: :likes_count
end
