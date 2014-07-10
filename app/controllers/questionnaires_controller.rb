class QuestionnairesController < ApplicationController
  def index
     if !signed_in?
        redirect_to (user_id_limit_path) and return
      else
     if !admin?
      redirect_to (user_id_limit_path) and return
    end
  end
    @questionnaires = Questionnaire.all
  end

  def set_limitations
    @questionnaire = Questionnaire.find(params[:id])
    if !admin? &&current_user.id != @questionnaire.user_id
      redirect_to (user_id_limit_path) and return
    end
    @relationship = Relationship.new
    @users = User.all
  end
  
	def new
    if !signed_in?
      redirect_to (user_signin_limit_path) and return
    end
		@questionnaire = Questionnaire.new
	end

	def create
    par = questionnaire_params
    par[:user_id] = current_user.id
    par[:qa_is_anonymous] = 0
    par[:qa_ip_limit] = 0
    par[:qa_user_limit] = 0
    par[:qa_status] = 0
    par[:closetime] = "2222-02-02"

    @questionnaire = Questionnaire.new(par)    # Not the final implementation!
    
    if @questionnaire.save
      flash[:success] = "Create Questionnaire Successfully!"
      redirect_to new_questions_questionnaire_path :id => @questionnaire
    else
      render 'new'
    end
	end

	def update
    @questionnaire = Questionnaire.find(params[:id])
      if @questionnaire.update_attributes(questionnaire_params)
        flash[:success] = "Update Successfully"
        redirect_to edit_questions_questionnaire_path :id => @questionnaire
      else
        flash[:error] = "Update Failed"
        render 'edit'
      end
	end

	def edit
           @questionnaire = Questionnaire.find(params[:id])
            if !signed_in?
        redirect_to (user_id_limit_path) and return
      else
            if !admin? &&current_user.id != @questionnaire.user_id
      redirect_to (user_id_limit_path) and return
    end
  end
	end

  def edit_questions
     @questionnaire = Questionnaire.find(params[:id])
      if !signed_in?
        redirect_to (user_id_limit_path) and return
      else
      if !admin? &&current_user.id != @questionnaire.user_id
      redirect_to (user_id_limit_path) and return
    end
  end
     @questions = @questionnaire.questions
     @question = Question.new
     @tempid = @questionnaire.id
  end

       def preshow
        @questionnaire = Questionnaire.find(params[:id])
         if !signed_in?
        redirect_to (user_id_limit_path) and return
      else
      if !admin? &&current_user.id != @questionnaire.user_id
      redirect_to (user_id_limit_path) and return
    end
  end
    @questions = @questionnaire.questions
       end

	def show
     @questionnaire = Questionnaire.find(params[:id])

     if @questionnaire.closetime <= DateTime.now
       @questionnaire.update_attribute(:qa_status, 0)
       redirect_to (questionnaire_timeup_path) and return
     end

     if @questionnaire.qa_status != 1
      if @questionnaire.qa_status == 0
         redirect_to (questionnaire_unpublished_path) and return
       else
        redirect_to (questionnaire_closed_path) and return
      end
     end

      if @questionnaire.qa_ip_limit == 1
         @results = Relationship.where( :questionnaire_id=> @questionnaire.id, :ip => request.remote_ip)
         if @results.count >=1
          redirect_to (user_ip_limit_path) and return
        end
      end
if !signed_in?
     if @questionnaire.qa_is_anonymous ==1
              redirect_to (user_signin_limit_path) and return
          end
else

       if @questionnaire.qa_user_limit == 1
         @results = Relationship.where( :questionnaire_id=> @questionnaire.id, :user_id => current_user.id)
         if @results.count >=1
          redirect_to (user_num_limit_path) and return
        end
      end

       if  @questionnaire.qa_special_list != ""
         @specialuserlist = (@questionnaire.qa_special_list).to_s.split(";")
         if !@specialuserlist.include?(current_user.id.to_s)
          redirect_to (user_special_limit_path) and return
        end
      end
end
    
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
        @questionnaire.update_attribute(:qa_status, 1)
        redirect_to set_limitations_questionnaire_path :id => @questionnaire.id
    else 
        flash[:error] = "Open Failed"
        redirect_to (:back)
    end

  end

  def reopen

   @questionnaire = Questionnaire.find(params[:id])  
    if @questionnaire &&  @questionnaire.qa_status!=1 && @questionnaire.qa_status!=0
         @questionnaire.update_attribute(:qa_status, 1)
        flash[:success] = "Questionnaire Reopened!"
        redirect_to (:back)
    else 
        flash[:error] = params[:id]
        redirect_to (:back)
    end

  end

  def publishresult

   @questionnaire = Questionnaire.find(params[:id])
    if !signed_in?
        redirect_to (user_id_limit_path) and return
      else
     if !admin? &&current_user.id != @questionnaire.user_id
      redirect_to (user_id_limit_path) and return
    end
  end
    if @questionnaire.qa_status ==2
        @questionnaire.update_attribute(:qa_status, 3)
        redirect_to (:back)
    else 
        flash[:error] = "Wrong questionnaire status for publishing result"
        redirect_to (:back)
    end

  end

   def new_questions
      @questionnaire = Questionnaire.find(params[:id])
       if !signed_in?
        redirect_to (user_id_limit_path) and return
      else
       if !admin? &&current_user.id != @questionnaire.user_id
      redirect_to (user_id_limit_path) and return
    end
  end
      @question = Question.new
      @tempid = @questionnaire.id
    end

  def close
 @questionnaire = Questionnaire.find(params[:id])
    
    if @questionnaire &&  @questionnaire.qa_status==1
        @questionnaire.update_attribute(:qa_status, 2)
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
     @tempuserid = current_user.id
  end
  
    def questionnaire_params
      params.require(:questionnaire).permit(:qa_title, :qa_subject, :qa_description, :closetime)
    end
def question_params
      params.require(:question).permit(:data, :questionnaire_id)
    end
  def answer_params
      params.require(:answer).permit(:data)
    end
def relationship_params
      params.require(:relationship).permit(:ip)
    end
    def report 
    @questionnaire=Questionnaire.find(params[:id])
     if !signed_in?
        redirect_to (user_id_limit_path) and return
      else
    if @questionnaire.qa_status != 3 && !admin? &&current_user.id != @questionnaire.user_id
      redirect_to (user_id_limit_path) and return
    end
  end
    @questions=@questionnaire.questions
    @datahash=Hash.new 
    @questions.each_with_index do |q,index|
   if q.q_type==1||q.q_type==3||q.q_type==2
      if q.q_type==1||q.q_type==2
      @choices=q.q_choice.split(";") 
    end
      if q.q_type==3
        @choices=["TRUE","FALSE"];
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

    def info
      if !signed_in?
        redirect_to (user_id_limit_path) and return
      else
       if !admin?
      redirect_to (user_id_limit_path) and return
    end
  end
      @allquestionnairescount=Questionnaire.all.count;
    @qcounts=Array.new(7,0);
    @acounts=Array.new(7,0) ;
    for i in 0..6
    @qcounts[i]=Questionnaire.where(created_at:(Time.now-(6-i).day).midnight.to_s..(Time.now+1.day-(6-i).day).midnight.to_s).count;
    @acounts[i]=Relationship.where(created_at:(Time.now-(6-i).day).midnight.to_s..(Time.now+1.day-(6-i).day).midnight.to_s).count;
    end
    end
end

