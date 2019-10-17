class UsersController < ApplicationController
  before_action(:authenticate_user, {only: [:index, :show, :edit, :update]})
  before_action(:forbid_login_user, {only: [:new, :create, :login, :login_form]})
  before_action(:ensure_correct_user, {only: [:edit, :update, :destroy]})

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
      image_name: "default_user.jpg",
      password: params[:password]
    )

    if @user.save
      flash[:notice] = "ユーザー登録が完了しました。"
      session[:user_id] = @user.id
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
    User.find_by(id: params[:id]).destroy
    Post.where(user_id: params[:id]).destroy_all
    Like.where(user_id: params[:id]).destroy_all
    session[:user_id] = nil
    flash[:notice] = "ユーザを削除しました。"
    redirect_to("/")
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      flash[:notice] = "ログインしました。"
      session[:user_id] = @user.id
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました。"
    redirect_to("/login")
  end

  def ensure_correct_user
    if session[:user_id] != params[:id].to_i
      flash[:notice] = "権限がありません。"
      redirect_to("/posts/index")
    end
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end
end
