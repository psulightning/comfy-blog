# To change this template, choose Tools | Templates
# and open the template in the editor.

class RemoveEmail < ActiveRecord::Migration
  def self.up
    remove_column :blog_comments, :email
  end
  
  def self.down
    add_column :blog_comments, :email, :string
  end
end
