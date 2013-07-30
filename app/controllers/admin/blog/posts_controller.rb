class Admin::Blog::PostsController < Admin::Blog::BaseController
  
  before_filter :build_post, :only => [:new, :create]
  before_filter :load_post,  :only => [:edit, :update, :destroy]
  
  def index
    @posts = if defined? WillPaginate
      Blog::Post.paginate :page => params[:page]
    elsif defined? Kaminari
      Blog::Post.page params[:page]
    else
      Blog::Post.all
    end
  end
  
  def new
    render
  end
  
  def create
    @post.save!
    flash[:notice] = 'Blog Post created'
    redirect_to :action => :edit, :id => @post
    
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create Blog Post'
    render :action => :new
  end
  
  def edit
    render
  end
  
  def update
    @post.update_attributes!(params[:post])
    flash[:notice] = 'Blog Post updated'
    redirect_to :action => :edit, :id => @post
    
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update Blog Post'
    render :action => :edit
  end
  
  def destroy
    @post.destroy
    flash[:notice] = 'Blog Post removed'
    redirect_to :action => :index
  end
  
protected
  
  def load_post
    @post = Blog::Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Blog Post not found'
    redirect_to :action => :index
  end
  
  def build_post
    @post = Blog::Post.new(post_params)
  end
  
  private
  def post_params
    params.permit(post: [:title, :slug, :author,
      :tag_names, :excerpt, :content, :published_at, :is_published, :category_ids])
  end
end