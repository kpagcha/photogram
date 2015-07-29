class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_attached_file :avatar, styles: { thumbnail: "48x48#", small: "100x100#" }, :default_url => "/images/:style/missing-avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :user_name, presence: true, length: { minimum: 4, maximum: 16 }, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Virtual attribute for authenticating by either username or email
  # This is an addition to a real persisted field, 'user_name'
  attr_accessor :login

  def self.find_for_database_authentication warden_conditions
  	conditions = warden_conditions.dup
  	if login = conditions.delete(:login)
  		where(conditions.to_hash).where(["user_name = :value OR lower(email) = lower(:value)", { value: login }]).first
  	else
  		conditions[:email].downcase! if conditions[:email]
  		where(conditions.to_hash).first
  	end
  end

  def to_param
    user_name
  end
end
