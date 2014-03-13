require "spec_helper"

feature "Viewing blog posts" do
  scenario "public users can view blog posts" do
    @post = create(:post, title: "Great story")
    visit blog_path
    expect(page).to have_content(@post.title)
  end
end