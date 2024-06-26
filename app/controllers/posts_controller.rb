class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_user, only: [:index]
  before_action :set_posts, only: [:index]

  # GET /users/1/posts
  def index
    page_number = params[:page] || 1
    per_page = params[:per_page] || 10
    offset = (page_number.to_i - 1) * per_page.to_i
  
    total_posts = @posts.count
    paginated_posts = @posts.limit(per_page).offset(offset)
  
    render json: {
      posts: paginated_posts,
      pagination: {
        current_page: page_number.to_i,
        per_page: per_page.to_i,
        total_pages: (total_posts.to_f / per_page.to_i).ceil,
        total_posts: total_posts
      }
    }
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

   # POST /posts or /posts.json
def create
  @post = Post.new(post_params)

  respond_to do |format|
    if @post.save
      format.json { render json: @post, status: :created }
    else
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end
end

# GET /posts/top
def top
  page_number = params[:page] || 1
  per_page = params[:per_page] || 10
  offset = (page_number.to_i - 1) * per_page.to_i

  total_top_posts = Post.count # Get total count of top posts
  top_posts = Post.order(created_at: :desc).limit(per_page).offset(offset)

  render json: {
    top_posts: top_posts,
    pagination: {
      current_page: page_number.to_i,
      per_page: per_page.to_i,
      total_pages: (total_top_posts.to_f / per_page.to_i).ceil,
      total_top_posts: total_top_posts
    }
  }
end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posts
      @posts = @user.posts
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end
