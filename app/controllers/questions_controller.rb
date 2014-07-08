class QuestionsController < ApplicationController
  
  def new
    @question = Question.new
  end

  def destroy
    Question.find(params[:id]).destroy
  end 

  def create
    @data = question_params[:data]
    @temp_id=question_params[:questionnaire_id]

    @tempquestionnaire = Questionnaire.find(@temp_id)
    @tempquestions = @tempquestionnaire.questions

    @tempquestions.each do |question|
      question.destroy
    end

    @hash = ActiveSupport::JSON.decode(@data)
    
    @sig_array = @hash["single"]
    if(!@sig_array.nil?)
      @sig_array.each_with_index do |question,i|
        @title = question["title"]
        @answer = question["choices"]
        @question = Question.new(questionnaire_id: @temp_id, q_type: "1", q_content: @title, q_choice: @answer, q_index: i+1)
        if @question.save
        else
        end
      end
    else
    end

    @multi_array = @hash["multi"]
    if(!@multi_array.nil?)
      @multi_array.each_with_index do |question,i|
        @title = question["title"]
        @answer = question["choices"]
        @question = Question.new(questionnaire_id: @temp_id, q_type: "2", q_content: @title, q_choice: @answer, q_index: i+1)
        if @question.save
        else
        end
      end
    else
    end

    @true_array = @hash["true"]
    if(!@true_array.nil?)
      @true_array.each_with_index do |question,i|
        @title = question["title"]
        @question = Question.new(questionnaire_id: @temp_id, q_type: "3", q_content: @title, q_choice:"", q_index: i+1)
        if @question.save
        else
        end
      end
      else
    end

    @essay_array = @hash["essay"]
    if(!@essay_array.nil?)
      @essay_array.each_with_index do |question,i|
        @title = question["title"]
        @question = Question.new(questionnaire_id: @temp_id, q_type: "4", q_content: @title, q_choice:"", q_index: i+1)
        if @question.save
        else
        end
      end
    else
    end
    redirect_to my_questionnaires_user_path(current_user.id)
    #create_url_path :id => @temp_id
  end

  def show
  
  end

  def edit

  end
  def save
	par = question_params
	puts par[:data]
  end

  
  def question_params
      params.require(:question).permit(:data, :questionnaire_id)
    end
end
