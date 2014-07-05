class QuestionnairesController < ApplicationController


  def my_questionnaires 
   @questionnaires = Questionnaire.where(user_id: current_user.id)
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
      redirect_to root_path
    else
      render 'new'
    end
	end

	def update
	end

	def edit
	end

	def show
	end

  def destroy
    Questionnaire.find(params[:id]).destroy
    flash[:success]="Questionnaire destroyed."
    redirect_to my_questionnaires_path
  end 

  def open

   @questionnaire = Questionnaire.find(params[:id])
    
    if @questionnaire &&  @questionnaire.qa_status!=1
        @questionnaire.update_attributes(:qa_status=>1)
        flash[:success] = "Questionnaire Opened !"
        #redirect_to my_questionnaires_path
        redirect_to my_questionnaires_path
    else 
        flash[:error] = params[:id]
        #render my_questionnaires_path
        redirect_to my_questionnaires_path
    end
  end

  def close
 @questionnaire = Questionnaire.find(params[:id])
    
    if @questionnaire &&  @questionnaire.qa_status==1
        @questionnaire.update_attributes(:qa_status=>3)
        flash[:success] = "Questionnaire Closed !"
        #redirect_to my_questionnaires_path
        redirect_to my_questionnaires_path
    else 
        flash[:error] = params[:id]
        #render my_questionnaires_path
        redirect_to my_questionnaires_path
    end
  end 

	private
    def questionnaire_params
      params.require(:questionnaire).permit(:qa_title, :qa_subject, :qa_description)
    end

end

