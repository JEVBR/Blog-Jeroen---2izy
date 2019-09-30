class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  
  def index
    @posts = policy_scope(Post).reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = current_user.posts.new
    authorize @post
  end

  def edit
  end

  def create
    @post = current_user.posts.create(post_params)
    authorize @post
    if @post.save
      redirect_to @post, notice: 'Post was sucessfully created'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was sucessfully updated'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was sucessfully removed'
  end

  private
  def set_post
      @post = Post.find(params[:id])
      authorize @post
  end

  def post_params
      params.require(:post).permit(:title, :user_id, :body)
  end
end
