class SessionsController < ApplicationController
  def new
  end
#making a new user here becuase on the LP it says to make  the tests in spec/features/sessions/logging_in_spec.rb
  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      flash[:errors] = ["Invalid combination"]
      redirect_to new_session_path
    end

  end#end create

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end#end destory 

end

