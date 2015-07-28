class Post < ActiveRecord::Base
	validates :user_id, presence: true
	validates :image, presence: true
	validates :caption, length: { minimum: 3, maximum: 300 }

	has_attached_file :image, styles: { small: "350x", medium: "640x", big: "900x" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	belongs_to :user
	has_many :comments, dependent: :destroy

	@@comment_limit = 5

	def last_comments limit
		comments.order("created_at DESC").take(limit)
	end

	def self.comment_limit
		@@comment_limit
	end
end
