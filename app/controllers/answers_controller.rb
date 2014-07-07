class AnswersController < ApplicationController
	def new
		@answer = Answer.new

	end

	def create
    @data = answer_params[:data]

    @hash = ActiveSupport::JSON.decode(@data)
     flag = true
    @ans_array = @hash["all"]
    if(!@ans_array.empty?)
      @ans_array.each_with_index do |answer,i|
        @ques_id = answer["question_id"]
        @ans_content = answer["answer_content"]
       
        @answer = Answer.new(question_id: @ques_id, user_id: current_user.id, answer_content: @ans_content)
        if @answer.save
        	flash[:success] = "Submit Successfully! Thank you for participating."
      

        else
        	 flash[:error] = "Submit Falied!"
        	 flag = false
        end
      end
    else
    	flash[:error] = "Incompelete Answer!"
        	 flag = false
    end
if flag
	redirect_to answer_successfully_path
end
	end

	def show

	end

	private
	def answer_params
		params.require(:answer).permit(:data)
	end
end