# To change this template, choose Tools | Templates
# and open the template in the editor.

class AuthorInteger < ActiveRecord::Migration
  def self.up
    change_column :blog_posts, :author, :integer
    rename_column :blog_posts, :author, :author_id
    
    change_column :blog_comments, :author, :integer
    rename_column :blog_comments, :author, :author_id
  end
  
  def self.down
    rename_column :blog_comments, :author_id, :author
    rename_column :blog_posts, :author_id, :author
    
    change_column :blog_comments, :author, :string
    change_column :blog_posts, :author, :string
  end
end
