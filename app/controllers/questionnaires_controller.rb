class QuestionnairesController < ApplicationController
  def index
    @questionnaires = Questionnaire.all
  end
  
	def new
		@questionnaire = Questionnaire.new
	end

	def create
    par = questionnaire_params
    par[:user_id] = current_user.id
    par[:qa_is_anonymous] = 0
    par[:qa_ip_limit] = 0
    par[:qa_user_limit] = 0
    par[:qa_status] = 0

    @questionnaire = Questionnaire.new(par)    # Not the final implementation!
    
    if @questionnaire.save
      flash[:success] = "Create Questionnaire Successfully!"
      redirect_to new_questions_questionnaire_path :id => @questionnaire
    else
      render 'new'
    end
	end

	def update
	end

	def edit

	end

  def edit_questions
     @questionnaire = Questionnaire.find(params[:id])
     @questions = @questionnaire.questions
     @question = Question.new
     @tempid = @questionnaire.id
  end

	def show
     @questionnaire = Questionnaire.find(params[:id])
     @questions = @questionnaire.questions
     @answer = Answer.new
	end

  def destroy
    Questionnaire.find(params[:id]).destroy
    flash[:success]="Questionnaire destroyed."
    redirect_to (:back)
  end 

  def open

   @questionnaire = Questionnaire.find(params[:id])
    
    if @questionnaire &&  @questionnaire.qa_status!=1
        @questionnaire.update_attributes(:qa_status=>1)
        redirect_to create_url_path :id => @questionnaire.id
    else 
        flash[:error] = params[:id]
        redirect_to (:back)
    end

  end

   def new_questions
      @questionnaire = Questionnaire.find(params[:id])
      @question = Question.new
      @tempid = @questionnaire.id
    end

  def close
 @questionnaire = Questionnaire.find(params[:id])
    
    if @questionnaire &&  @questionnaire.qa_status==1
        @questionnaire.update_attributes(:qa_status=>3)
        flash[:success] = "Questionnaire Closed !"
        redirect_to (:back)
    else 
        flash[:error] = params[:id]
        redirect_to (:back)
    end
  end 

  def show_answer
    @questionnaire = Questionnaire.find(params[:id])
     @questions = @questionnaire.questions
     @answer = Answer.new
  end
  
    def questionnaire_params
      params.require(:questionnaire).permit(:qa_title, :qa_subject, :qa_description)
    end
def question_params
      params.require(:question).permit(:data, :questionnaire_id)
    end
  def answer_params
      params.require(:answer).permit(:data)
    end

    def report 
    @questionnaire=Questionnaire.find(params[:id]);
    @questions=@questionnaire.questions
    @datahash=Hash.new 
    @questions.each_with_index do |q,index|
   if q.q_type==1||q.q_type==3||q.q_type==2
      if q.q_type==1||q.q_type==2
      @choices=q.q_choice.split(";") 
    end
      if q.q_type==3
        @choices=["True","False"];
      end
      @items=Array.new(@choices.length,0) 
      @answers=q.answers;
      @choices.each_with_index do |onechoice,index| 
                @answers.each  do |answer|
                @eachanswers=answer.answer_content.split(";")
                if @eachanswers.include?onechoice
                    @items[index]=@items[index]+1;
                end
               end
      end
      @datahash[q.id]= @items
    end
  end
    end
end

