class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # Make sure user is authenticated before creating a post.
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end
