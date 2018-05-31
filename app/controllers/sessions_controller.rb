class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(login_id: params[:session][:login_id])
    if user && user.authenticate(params[:session][:password])
      # ログイン処理
      login user
      redirect_to group_chats_url(user.groups.first.id, session: user_params)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    logout
    redirect_to root_url
  end

  private

    def user_params
      params.require(:session).permit(:login_id, :user_id)
    end
end
