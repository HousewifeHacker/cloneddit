class Sub < ActiveRecord::Base
  validates :title, uniqueness: true
  validates :title, :moderator_id, presence: true
  
  belongs_to( :moderator, class_name: 'User' )
  
  has_many :post_subs, dependent: :destroy
  has_many :posts, through: :post_subs 
end
