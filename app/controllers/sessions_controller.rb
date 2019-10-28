class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate(params[:session][:password])
      login_remember
    else
      flash[:danger] = t "invalid_combination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_remember
    log_in @user
    if params[:session][:remember_me] == Settings.p_
      remember @user
    else
      forget @user
    end
    redirect_back_or @user
  end
end
