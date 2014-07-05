class Questionnaire < ActiveRecord::Base
	has_many :questions
	has_many :relations
	belongs_to :user

	validates :qa_title , presence: true, length: {maximum: 50}
	validates :qa_subject , presence: true, length: {maximum: 50}
	validates :qa_description , presence: true, length: {maximum: 200}
	#validates_numericality_of :user_id, :integer_only=>true
	#validates_numericality_of :qa_is_anonymous, :integer_only=>true
	#validates_numericality_of :qa_ip_limit, :integer_only=>true
	#validates_numericality_of :qa_user_limit, :integer_only=>true
end
