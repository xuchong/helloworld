class Question < ActiveRecord::Base
    belongs_to :quesitonnaire
    has_many :answers, :dependent => :destroy
end
