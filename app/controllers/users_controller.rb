class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.jpg"
    )

    if @user.save
      flash[:notice] = "ユーザー登録が完了しました。"
      redirect_to("/users/index")
    else
      render("/users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if @user.save
      flash[:notice] = "ユーザーの編集が完了しました。"
      redirect_to("/users/index")
    else
      render("/users/edit")
    end
  end

  def destroy
    @user = User.find_by(id: params[:id]).destroy
    redirect_to("/users/index")
  end
end
