require_dependency "survey_builder/application_controller"

module SurveyBuilder
  class AnswersController < ApplicationController
    before_action :set_survey_form!
    before_action :set_answer, only: [:show, :edit, :update, :destroy]

    # GET /answers
    def index
      @answers = Answer.all
    end

    # GET /answers/1
    def show
    end

    # GET /answers/new
    def new
      @answer = Answer.new
    end

    # GET /answers/1/edit
    def edit
    end

    # POST /answers
    def create
      @answer = Answer.new(answer_params)

      if @answer.save
        redirect_to @answer, notice: 'Answer was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /answers/1
    def update
      if @answer.update(answer_params)
        redirect_to @answer, notice: 'Answer was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /answers/1
    def destroy
      @answer.destroy
      redirect_to answers_url, notice: 'Answer was successfully destroyed.'
    end

    private
      
      # Use callbacks to share common setup or constraints between actions.
      def set_survey_form!
        @survey_form = SurveyForm.find(params[:survey_form_id])
      end

      def set_answer
        @answer = Answer.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def answer_params
        params.require(:answer).permit(:question_id, :user_id, :answer_data, :time)
      end
  end
end