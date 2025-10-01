class EchosController < ApplicationController
  before_action :set_echo, only: [ :show, :edit, :update, :destroy ]

  def index

    if current_user.teacher?
      @echos = current_classroom.echos.includes(:classroom).ordered
    else
      @echos = current_classroom.echos.public_echos.includes(:classroom).ordered
    end
  end

  def show
    # Use includes to prevent N+1 queries when rendering echo dates
    @echo_dates = @echo.echo_dates.includes(:echo).ordered
  end

  def new
    @echo = Echo.new
  end

  def create
    @echo = current_classroom.echos.build(echo_params)

    if @echo.save
      respond_to do |format|
        format.html { redirect_to echos_path, notice: "Echo was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Echo was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @echo.update(echo_params)
      respond_to do |format|
        format.html { redirect_to echos_path, notice: "Echo was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Echo was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @echo.destroy

    respond_to do |format|
      format.html { redirect_to echos_path, notice: "Echo was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Echo was successfully destroyed." }
    end
  end

  private

  def set_echo
    @echo = current_classroom.echos.find(params[:id])
  end

  def echo_params
    permitted_params = [ :name ]
    permitted_params << :private if current_user.teacher?
    params.require(:echo).permit(permitted_params)
  end
end
