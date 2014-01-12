# To change this template, choose Tools | Templates
# and open the template in the editor.

module Blog::PostsHelper
  def author_link(obj)
    current_user.logged? ? link_to(obj.author, user_path(obj.author)) : obj.author
  end 
end
