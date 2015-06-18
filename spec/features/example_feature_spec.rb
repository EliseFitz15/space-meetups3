require 'spec_helper'

# As a user
# I want to view a list of all available meetups
# So that I can get together with people with similar interests

feature "User views the index page" do
  scenario "user sees the correct title" do
    space_ruby = Meetup.create({name: "Space Ruby", description: "Code in space.", location: "Mars"})
    alphabet = Meetup.create({name: "Alphabet Soup", description: "Letters in space.", location: "Orions Belt"})
    user = User.create({provider: "github", uid: "10551597", username: "EliseFitz15", email: "elise.fitzgerald15@gmail.com", avatar_url: "https://avatars.githubusercontent.com/u/10551597?v..."})

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
    user = User.create({provider: "github", uid: "10551597", username: "EliseFitz15", email: "elise.fitzgerald15@gmail.com", avatar_url: "https://avatars.githubusercontent.com/u/10551597?v..."})

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
  scenario "user cannot fill out form to create meetup if not logged in" do
    visit "/"
    fill_in "name", with: "Friends fan club"
    fill_in "description", with: "Watch Friends marathons"
    fill_in "location", with: "Pluto"
    click_button "Add Meetup"
    expect(page).to have_content("You need to sign in if you want to do that!")
  end

  scenario "user logs in and can fill out form to create meetup" do
    user = User.create({provider: "github", uid: "10551597", username: "EliseFitz15", email: "elise.fitzgerald15@gmail.com", avatar_url: "https://avatars.githubusercontent.com/u/10551597?v..."})
    visit "/"
    sign_in_as(user)
    fill_in "name", with: "Friends fan club"
    fill_in "description", with: "Watch Friends marathons"
    fill_in "location", with: "Pluto"
    click_button "Add Meetup"
    expect(page).to have_content("Description:")
    expect(page).to have_content("Friends fan club")
  end
end

# I must be signed in.
# From a meetups detail page, I should click a button to join the meetup.
# I should see a message that tells let's me know when I have successfully joined a meetup.

feature "User once signed in can join a meet up" do
  scenario "user is not signed-in but tries to join meetup" do
    space_ruby = Meetup.create({name: "Space Ruby", description: "Code in space.", location: "Mars"})
    visit '/'
    click_link "Space Ruby"
    expect(page).to have_content("Description:")
    click_button "Join Meetup"
    expect(page).to have_content("You need to sign in if you want to do that!")
  end
  scenario "user signs in and joins a meetup" do
    space_ruby = Meetup.create({name: "Space Ruby", description: "Code in space.", location: "Mars"})
    user = User.create({provider: "github", uid: "10551597", username: "EliseFitz15", email: "elise.fitzgerald15@gmail.com", avatar_url: "https://avatars.githubusercontent.com/u/10551597?v..."})
    visit '/'
    sign_in_as(user)
    click_link "Space Ruby"
    expect(page).to have_content("Description:")
    click_button "Join Meetup"
    expect(page).to have_content("You've joined a meetup")
  end

end
