class QuestionsController < ApplicationController
  
  def new
  end

  def add_questions
  end
  
  def show_questions
    @questionnaires = Questionnaire.where(id: "1")
    @questions = Question.where(questionnaire_id: "1")
  end 

  def edit

  end

  def create
        #puts params[:]
  end

  def  get_answer 
       
   end
end