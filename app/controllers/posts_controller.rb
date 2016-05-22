class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.all.paginate(page: params[:page], :per_page => 5)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.paginate(page: params[:page], :per_page => 4)
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
        redirect_to @post
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy
    redirect_to posts_path
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:title,:text)
  end
end
