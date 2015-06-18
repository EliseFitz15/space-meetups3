require 'spec_helper'

# As a user
# I want to view a list of all available meetups
# So that I can get together with people with similar interests

feature "User views the index page" do
  scenario "user sees the correct title" do
    space_ruby = Meetup.create({name: "Space Ruby", description: "Code in space.", location: "Mars"})
    alphabet = Meetup.create({name: "Alphabet Soup", description: "Letters in space.", location: "Orions Belt"})
    elise = User.create({provider: "github", uid: "10551597", username: "EliseFitz15", email: "elise.fitzgerald15@gmail.com", avatar_url: "https://avatars.githubusercontent.com/u/10551597?v..."})

    visit '/'

    expect(page).to have_content("List of All Meetups")
    expect(page).to have_content("Alphabet Soup")
    expect(page).to have_content("Space Ruby")

  end
end

# As a user
# I want to view the details of a meetup
# So that I can learn more about its purpose

feature "User views details of meetup" do
  scenario "user clicks meetup name and views page with details" do
    space_ruby = Meetup.create({name: "Space Ruby", description: "Code in space.", location: "Mars"})
    elise = User.create({provider: "github", uid: "10551597", username: "EliseFitz15", email: "elise.fitzgerald15@gmail.com", avatar_url: "https://avatars.githubusercontent.com/u/10551597?v..."})

    visit "/"

    expect(page).to have_content("List of All Meetups")
    expect(page).to have_content("Space Ruby")
    click_link "Space Ruby"
    expect(page).to have_content("Description:")
    expect(page).to have_content("Code in space.")
  end
end


# As a user
# I want to create a meetup
# So that I can gather a group of people to discuss a given topic

feature "User can create a new meetup" do
  scenario "user logs in and can fill out form to create meetup" do
    visit "/"
    fill_in "name", with: "Friends fan club"
    fill_in "description", with: "Watch Friends marathons"
    fill_in "location", with: "Pluto"
    click_button "Add Meetup"
    expect(page).to have_content("Description:")
    expect(page).to have_content("Friends fan club")
  end
end
