class UsersController < ApplicationController
  #before_filter :login_required, :only => :show
  
  def new
    @user = User.new 
    if request.post?
        @user = User.find_by({email: params[:user][:email]})
        if @user.authenticate(params[:user][:password_digest])
          log_in @user
          redirect_to dashboard_path
        else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
        end
    end
  end
  
  # show the user details after authentication
  def dashboard
     
  end
  
  #register the new user
  def register()
    @user = User.new
    if request.post?
      @user = User.new(user_params)
      if @user.save
        log_in @user
        redirect_to dashboard_path
      else
        render 'register'
      end
    else  
      render 'register'
    end
  end
  
  # logout the current user
  def destroy
    log_out
    redirect_to root_url
  end
  
  def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation)
  end
   
end
