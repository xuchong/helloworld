class StaticPagesController < ApplicationController
  def home
    @questionnaires = Questionnaire.where(qa_is_anonymous: 0, qa_status: 1)
  end

  def help
  end

  def about
  end

  def contact
  end

  def answer_successfully
  end

def questionnaire_closed
end
def questionnaire_unpublished
end
def questionnaire_timeup
  end
def user_ip_limit
end
def user_signin_limit
end
def user_num_limit
end
def user_special_limit
end
  def user_shutdown
  end

  def user_id_limit
  end

  def qrcode
     @questionnaire = Questionnaire.find(params[:id])
     @tempstring =  request.protocol + request.host_with_port  + "/questionnaires/"+  @questionnaire.id.to_s
 	   @qr = RQRCode::QRCode.new(@tempstring, :size=>4, :level=>:l)
  end
end
