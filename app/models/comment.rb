class Comment < ActiveRecord::Base
  validates :content, :author, :post, presence: true
  
  belongs_to :author, class_name: "User"
  belongs_to :post
end
