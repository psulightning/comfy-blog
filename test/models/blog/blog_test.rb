require_relative '../../test_helper'

class BlogTest < ActiveSupport::TestCase
  
  def test_site_association
    assert_equal [blog_blogs(:default)], cms_sites(:default).blogs
  end

  def test_fixtures_validity
    Blog::Blog.all.each do |blog|
      assert blog.valid?, blog.errors.inspect
    end
  end
  
  def test_validation
    blog = Blog::Blog.new
    assert blog.invalid?
    assert_errors_on blog, :site_id, :label, :identifier, :path
  end
  
  def test_validation_path_presence
    blog_a = blog_blogs(:default)
    refute blog_a.path.present?
    
    blog_b = cms_sites(:default).blogs.new(
      :label      => 'Test Blog A',
      :identifier => 'test-blog-a'
    )
    assert blog_b.invalid?
    assert_errors_on blog_b, :path
    
    blog_a.update_column(:path, 'blog-a')
    assert blog_b.invalid?
    assert_errors_on blog_b, :path
    
    blog_b.path = 'blog-a'
    assert blog_b.invalid?
    assert_errors_on blog_b, :path
    
    blog_b.path = 'blog-b'
    assert blog_b.valid?
  end
  
  def test_creation
    assert_difference 'Blog::Blog.count' do
      cms_sites(:default).blogs.create(
        :label      => 'Test Blog',
        :identifier => 'test-blog',
        :path       => 'test-blog'
      )
    end
  end
  
  def test_destroy
    assert_difference ['Blog::Blog.count', 'Blog::Post.count'], -1 do
      blog_blogs(:default).destroy
    end
  end
end