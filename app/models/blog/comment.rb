class Blog::Comment < ActiveRecord::Base
  
  self.table_name = :blog_comments
  
  # -- Relationships --------------------------------------------------------
  belongs_to :post
  
  # -- Callbacks ------------------------------------------------------------
  before_create :set_publish
    
  # -- Validations ----------------------------------------------------------
  validates :post_id, :content, :author, :email, 
    :presence => true
  validates :email,
    :format => { :with => /\A([\w.%-+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :multiline=>true }
    
  # -- Scopes ---------------------------------------------------------------
  scope :published, where(:is_published => true)
  
protected
  
  def set_publish
    self.is_published = ComfyBlog.config.auto_publish_comments
    return
  end
  
end