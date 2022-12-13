class TimesheetsController < ApplicationController
  before_action :set_timesheet, only: %i[show update destroy edit]

  def index
    @timesheets =
      if params[:user_id].blank?
        Timesheet.all
      else
        Timesheet.where(user_id: params[:user_id])
      end
  end

  def new
    @timesheet = Timesheet.new
  end

  def create
    @timesheet = Timesheet.new(timesheet_params)
    if @timesheet.save
      redirect_to timesheets_path, notice: 'The timesheet has been added'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @timesheet = Timesheet.find(params[:id])
  end

  def edit

  end

  def update
    if @timesheet.update(timesheet_params)
      redirect_to timesheet_path(@timesheet)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @timesheet.destroy
    redirect_to timesheets_path, notice: 'The timesheet has been deleted'
  end

  private

  def set_timesheet
    @timesheet = Timesheet.find(params[:id])
  end

  def timesheet_params
    params.require(:timesheet).permit(:user_id, :check_in, :check_out, :day)
  end
end
