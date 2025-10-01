class AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :login, :authenticate, :signup, :create_user, :logout ]

  def login
    # Show login form
  end

  def authenticate
    user = User.find_by(email: params[:auth][:email])

    Rails.logger.info "Auth attempt: email=#{params[:auth][:email]}, user_found=#{user.present?}"

    if user
      password_match = BCrypt::Password.new(user.encrypted_password) == params[:auth][:password]
      Rails.logger.info "Password match: #{password_match}"

      if password_match
        session[:user_id] = user.id
        redirect_to echos_path, notice: "Welcome back, #{user.name}!"
      else
        flash[:alert] = "Invalid email or password"
        redirect_to login_path
      end
    else
      flash[:alert] = "Invalid email or password"
      redirect_to login_path
    end
  end

  def signup
    @user = User.new
    @classrooms = Classroom.all
  end

  def create_user
    @user = User.new(user_params)
    @classrooms = Classroom.all

    if @user.save
      session[:user_id] = @user.id
      redirect_to echos_path, notice: "Welcome, #{@user.name}! Your account has been created."
    else
      render :signup, status: :unprocessable_entity
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path, notice: "You have been logged out"
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :user_type, :classroom_id)
  end
end
