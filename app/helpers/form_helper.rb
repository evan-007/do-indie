module FormHelper
  def setup_post(post)
    post.slide ||= Slide.new
    post
  end
end