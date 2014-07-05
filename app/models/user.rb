class User < ActiveRecord::Base
   has_many :questionnaire
   has_many :answer
   has_many :relation

	before_save { self.user_email = user_email.downcase }
  before_create :create_remember_token

	validates :user_name , presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :user_email , presence: true, 
					   format: {with: VALID_EMAIL_REGEX}, 
             uniqueness: { case_sensitive: false }

  validates :user_age , presence: true
  validates_numericality_of :user_age, :integer_only=>true

  has_secure_password
  validates :password, length: { minimum: 6 }  

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end 

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
