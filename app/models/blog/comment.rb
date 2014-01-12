class Blog::Comment < ActiveRecord::Base
  
  self.table_name = 'blog_comments'
  
  # -- Relationships --------------------------------------------------------
  belongs_to :post
  belongs_to :author, class_name: "User"
  # -- Callbacks ------------------------------------------------------------
  before_create :set_is_published
    
  # -- Validations ----------------------------------------------------------
  validates :post_id, :content, :author_id, :presence => true
    
  # -- Scopes ---------------------------------------------------------------
  scope :published, lambda{where(:is_published => true)}
  
  def email
    author.login
  end
  
protected
  
  def set_is_published
    self.is_published = ComfyBlog.config.auto_publish_comments
    return
  end
  
end
