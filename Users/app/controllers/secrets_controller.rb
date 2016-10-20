 class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]

  def index
    @secrets = Secret.all
  end#end of index 
  
  def create
    secret = Secret.new secret_params
    if secret.save
      flash[:success] = "Secret added!"
    else
      flash[:errors] = secret.errors
    end #end of if 

    redirect_to "/users/#{current_user.id}"
  end#end of redirect


 def destroy
    
    secret = Secret.find(params[:id]).destroy
    redirect_to "/users/#{current_user.id}" 
  end


  private
    def secret_params
      params.require(:secret).permit(:content).merge(user: current_user)
    end
 

end
