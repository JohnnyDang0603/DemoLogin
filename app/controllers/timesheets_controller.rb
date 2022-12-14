class TimesheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_timesheet, only: %i[show update destroy edit]
  before_action :check_access!, except: %i[index new create]
  # before_action :check_user_access!,
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
    if current_user.admin?
      @timesheet = Timesheet.new(timesheet_params)
    else
      @timesheet = Timesheet.new(timesheet_params.merge(user_id: curent_user.id))
    end

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
    if params[:timesheet][:user_id].present?
      params.require(:timesheet).permit(:user_id, :check_in, :check_out, :day)
    else
      params.require(:timesheet).permit(:check_in, :check_out, :day)
    end
  end

  def check_access!
    check_authorize(current_user)
  end

  # def check_access_user!
  #   check_authorize()
  # end

end
