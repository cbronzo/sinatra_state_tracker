class User < ActiveRecord::Base
  has_many :user_states
  has_many :states, through: :user_states


  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true

  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
