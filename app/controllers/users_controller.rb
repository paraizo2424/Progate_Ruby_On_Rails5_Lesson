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
    image = params[:image]
    if image
      @user.image_name = "#{@user.id}.jpg"
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
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

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:email],password: params[:password])
    if @user
      flash[:notice] = "ログインしました。"
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
end
