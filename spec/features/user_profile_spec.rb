require 'rails_helper'

feature 'Manager user profile' do
  context "without avatar" do
    scenario 'views user profile' do
      user = create(:user)
      sign_in user
      expect(page).to have_content(user.name)

      click_link user.name

      expect(page).to have_content(user.name)
    end
  end

  context "with avatar" do
    scenario 'views user profile' do
      pending "how to test with the avatar"
      user = create(:user_with_avatar)
      sign_in user
      expect(page).to have_tag("img")

      click_link user.name
      expect(page).to have_content(user.name)
    end
  end

  scenario "updates user profile" do
    user = create(:user)
    sign_in user
    click_link user.name
    fill_in "Name", with: "Jane Smith"
    within '#personal-info' do
      click_button "Update"
    end
    user.reload
    expect(user.name). to eq("Jane Smith")
  end
end
