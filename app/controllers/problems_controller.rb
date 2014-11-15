class ProblemsController < ApplicationController
  def index
  end

  def create
    problem = Problem.new problem_params

    if problem.save

      render json: {message: "Al peluche ñero :F"}
    else
      render json: {message: "Something went wrong :("} , status: 400
    end
  end

  private

  def problem_params
    permitted_params.permit!
  end

  def permitted_params
    params.require(:problem).permit(
          :name,
          :language,
          :description,
          :max_date,
          :solution,
          :solution_cache,
          :input,
          :input_cache
          )
  end
end
