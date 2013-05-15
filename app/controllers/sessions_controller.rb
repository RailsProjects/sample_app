class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
    # session[:user] = user.id 
    # http://stackoverflow.com/questions/10489314/how-can-i-use-form-tag-as-opposed-to-form-for-in-this-file

    # use these 2 lines instead when using form_for in sign-in form:

    # user = User.find_by_email(params[:session][:email].downcase)
    # if user && user.authenticate(params[:session][:password])
    
    # If you look at the actual parameters hash, using form_for 
    # and form_tag create a different internal structure. 
    # When using form_for, a nested hash is created inside the 
    # parameters hash. This hash contains :email, which is why you 
    # have to use the params[:session][:email] syntax. form_tag, 
    # on the other hand does not create a session hash. You can 
    # access the email field directly with params[:email]
     
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
end