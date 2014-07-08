class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def contact
  end

  def answer_successfully
  end

  def qrcode
     @questionnaire = Questionnaire.find(params[:id])
     @tempstring = 'http://localhost:3000/questionnaires/' +  @questionnaire.id.to_s
 	   @qr = RQRCode::QRCode.new(@tempstring, :size=>4, :level=>:l)
  end
end
