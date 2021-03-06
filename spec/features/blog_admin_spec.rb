require 'spec_helper'

feature 'Blog admin space' do
  before do
    @user = create(:blogger)
    @post = create(:post)
    @unpublished = create(:unpublished_post)
    sign_in @user
  end
  
  scenario "Blogger users can view all pending and active posts" do
    visit blog_path
    click_link "Blog Admin Page"
    expect(page).to have_content @post.title
    expect(page).to have_content @unpublished.title
  end
  
  scenario "Blogger users can edit posts" do
    visit blog_admin_en_path
    click_link @post.title
    fill_in "post[title]", with: "Hellowhowareyou?"
    check('post[published]')
    click_button('Update Post')
    expect(page).to have_content('Post updated')
  end
end
