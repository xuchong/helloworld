class RelationshipsController < ApplicationController
  def new
  end

  def create
    @data = relationship_params[:ip]
    @hash = ActiveSupport::JSON.decode(@data)
    @questionnaire = Questionnaire.find(@hash["id"])   
    if @questionnaire
        @questionnaire.update_attribute(:qa_is_anonymous, @hash["box3"])
        @questionnaire.update_attribute(:qa_ip_limit, @hash["box1"])
        @questionnaire.update_attribute(:qa_user_limit, @hash["box2"])
        
        @questionnaire.update_attribute(:qa_special_list, @hash["user"])
        if @hash["date"] == ""
          @questionnaire.update_attribute(:closetime, "3333-03-03")
        else
          @questionnaire.update_attribute(:closetime, @hash["date"])
        end
        redirect_to create_url_path :id => @questionnaire.id
    else 
        flash[:error] = "Saving Failed"
        redirect_to (:back)
    end
  end

  def show
  end

  def update
  end

  def relationship_params
      params.require(:relationship).permit(:ip)
    end
end
