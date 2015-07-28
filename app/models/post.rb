class Post < ActiveRecord::Base
	validates :user_id, presence: true
	validates :image, presence: true

	has_attached_file :image, styles: { small: "350x", medium: "640x", big: "900x" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	belongs_to :user
	has_many :comments, dependent: :destroy
end
