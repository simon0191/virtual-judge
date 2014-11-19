class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show]
  before_action :set_problem, only: [:create, :new]

  before_action :authenticate_user!, only: [:create, :new]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.order created_at: :desc
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  end

  # GET /problems/1/submissions/new
  def new
    @submission = Submission.new
  end

  # POST /problems/1/submissions
  # POST /problems/1/submissions.json
  def create
    @submission = Submission.new(submission_params)
    @submission.user = current_user
    @submission.problem = @problem

    respond_to do |format|
      if @submission.save
        @submission.execute_code
        format.html { redirect_to({action: 'index'}, {notice: 'Tu envío fue procesado'})}
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end
    def set_problem
      @problem = Problem.find(params[:problem_id])
    end

    def submission_params
      permitted_params.permit!
    end

    def permitted_params
      params.require(:submission).permit(
            :language,
            :source_code
            )
    end
end
