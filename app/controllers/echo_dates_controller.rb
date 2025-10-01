class EchoDatesController < ApplicationController
  before_action :set_echo
  before_action :set_echo_date, only: [ :edit, :update, :destroy ]

  def new
    @echo_date = @echo.echo_dates.build
  end

  def create
    @echo_date = @echo.echo_dates.build(echo_date_params)

    if @echo_date.save
      respond_to do |format|
        format.html { redirect_to echo_path(@echo), notice: "Date was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Date was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @echo_date.update(echo_date_params)
      respond_to do |format|
        format.html { redirect_to echo_path(@echo), notice: "Date was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Date was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @echo_date.destroy

    respond_to do |format|
      format.html { redirect_to echo_path(@echo), notice: "Date was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Date was successfully destroyed." }
    end
  end

  private

  def echo_date_params
    params.require(:echo_date).permit(:date)
  end

  def set_echo
    @echo = current_classroom.echos.find(params[:echo_id])
  end

  def set_echo_date
    @echo_date = @echo.echo_dates.find(params[:id])
  end
end
