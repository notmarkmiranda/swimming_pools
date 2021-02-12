class QuestionsController < ApplicationController
  def create
    pool = current_user.pools.find(question_params[:pool_id])
    @question = pool.questions.new(question_params)
    authorize @question
    return redirect_to pool if not_enough_choices?
    @question.save
    redirect_to pool
  end

  private

  def question_params
    params.require(:question).permit(:text, :pool_id, choices_attributes: [:text, :points])
  end

  def not_enough_choices?
    @question.choices.map(&:new_record?).count == 1
  end
end
