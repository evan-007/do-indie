require "spec_helper"

feature "Creating posts" do
  before do
     @blogger = create(:blogger)
  end
  
  scenario "Blogger users can access new posts" do
    sign_in @blogger
    visit blog_en_path
    expect(page).to have_content("New Post")
  end
  
  scenario "Non-blogger users cannot create new posts" do
    @user = create(:user)
    sign_in @user
    visit blog_en_path
    expect(page).to_not have_content("New Post")
  end
  
  scenario "Blogger users can create posts" do
    sign_in @blogger
    visit new_post_en_path
    fill_in "Title", with: "Create interview"
    fill_in "post[en_body]", with: "Here is my article"
    click_button "Create Post"
    expect(page).to have_content("Post Created!")
  end
end