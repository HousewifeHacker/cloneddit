class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
 
  belongs_to :author, class_name: "User"
  
  has_many :post_subs, dependent: :destroy
  has_many :subs, through: :post_subs
  
  has_many :comments, dependent: :destroy
end
