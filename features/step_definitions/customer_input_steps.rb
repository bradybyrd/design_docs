
Given(/there is a company named "([^"]*)"$/) do |comp|
  FactoryGirl.create(:company_with_all_related_objects, name: comp)
  puts "User: #{User.first.inspect}"
end

Given(/I am logged in as "([^"]*)" with password "([^"]*)"/) do |email, password|
  visit "/sign-in"
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Log in"
end

When(/I am on the "([^"]*)" page/) do |target_page|
  visit "/"
end

Then(/I should see the site "([^"]*)"/) do |site_name|
  expect(page).to have_text(site_name)
end