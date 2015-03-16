class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :body, presence: true, length: { minimum: 3 }
end
