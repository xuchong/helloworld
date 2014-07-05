class QuestionsController < ApplicationController
  
  def new
    puts "xuchongasdajkfssssssssssssssssssssssssssss"
    @question = Question.new
  end

  def create

    @out= "hahahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
    puts "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"

    @data = question_params[:data]
    @hash = ActiveSupport::JSON.decode(@data)
    redirect_to root_path
    
    @array = hash["single"]
    if(!@array.nil?)
      @array.each do |question|
        @title = question["title"]
        @answer = question["choices"]

        @question = Question.new(questionnaire_id: "1", q_type: "1", q_content: @title, q_choice: @answer, q_index: 1)
        if @question.save
        else
        end
      end
    else
    end
  end

  def show
  end

  def add_questions
	@question=Question.new
  end
  
  def show_questions
    @questionnaires = Questionnaire.where(id: "1")
    @questions = Question.where(questionnaire_id: "1")
  end 

  def edit

  end
  def save
	par = question_params
	puts par[:data]
  end

  def create
        #puts params[:]
  end

  def  get_answer 
       
   end
  def question_params
      params.require(:question).permit(:data)
    end
end
