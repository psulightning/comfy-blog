class Blog::CommentsController < ApplicationController
  
  def create
    @post = Blog::Post.published.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.save
    
    respond_to do |f|
      f.html do 
        flash[:notice] = 'Comment created'
        redirect_to dated_blog_post_path(@post.year, @post.month, @post.slug)
      end
      f.js
    end
    
  rescue ActiveRecord::RecordNotFound
    respond_to do |f|
      f.html do
        flash[:error] = 'Blog Post not found'
        redirect_to blog_posts_path
      end
      f.js do
        render :nothing => true, :status => 404
      end
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |f|
      f.html do
        render 'blog/posts/show'
      end
      f.js
    end
  end
  
  private
   def comment_params
     params.require(:comment).permit(:author_id, :content)
   end
end