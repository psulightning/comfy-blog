# To change this template, choose Tools | Templates
# and open the template in the editor.

module Blog::PostsHelper
  def author_link(obj)
    current_user.logged? ? link_to(obj.author, user_path(obj.author)) : "<i style='color:#6f686a'>#{obj.author}</i>".html_safe
  end 
end
