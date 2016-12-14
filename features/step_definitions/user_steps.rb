def user_details
  @user_info ||= { first_name: "JohnQ", last_name: "Public", email: "example@example.com",
    :password => "kittens4me", :password_confirmation => "kittens4me" }
end

def find_user
  @user ||= User.where(:email => @user_info[:email]).first
end

def create_unconfirmed_user
  user_details
  delete_user
  sign_up
  visit '/auth/sign_out'
end

def create_user
  user_details
  delete_user
  @user = FactoryGirl.create(:user, @user_info)
end

def delete_user
  @user ||= User.where(:email => @user_info[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/auth/sign_up'
  fill_in "user_name", :with => @user_info[:name]
  fill_in "user_email", :with => @user_info[:email]
  fill_in "user_password", :with => @user_info[:password]
  fill_in "user_password_confirmation", :with => @user_info[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/auth/sign_in'
  fill_in "user_email", :with => @user_info[:email]
  fill_in "user_password", :with => @user_info[:password]
  click_button "Log in"
  User.current_user = find_user
end

### GIVEN ###
Given /^I am not logged in$/ do
  http_delete '/auth/sign_out'
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  user_details
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  user_details
  sign_in
end

When /^I sign out$/ do
  http_delete '/auth/sign_out'
end

When /^I sign up with valid user data$/ do
  user_details
  sign_up
end

When /^I sign up with an invalid email$/ do
  user_details
  @user_info = @user_info.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  user_details
  @user_info = @user_info.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  user_details
  @user_info = @user_info.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  user_details
  @user_info = @user_info.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @user_info = @user_info.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @user_info = @user_info.merge(:password => "wrongpass")
  sign_in
end

When(/^I save the edit form$/) do
  click_button "Update"
end

When /^I edit my account name$/ do
  click_link "Edit account"
  fill_in "user_name", :with => "newname"
  fill_in "user_current_password", :with => @user_info[:password]
end

When /^I edit my email address$/ do
  click_link "Edit account"
  fill_in "user_email", :with => "newemail@example.com"
  fill_in "user_current_password", :with => @user_info[:password]
end

When(/^I don't enter my current password$/) do
  fill_in "user_current_password", :with => ""
end

When(/^I edit my email address with an invalid email$/) do
  click_link "Edit account"
  fill_in "user_email", :with => "notanemail"
  fill_in "user_current_password", :with => @user_info[:password]
end

When(/^I edit my password$/) do
  click_link "Edit account"
  fill_in "user_password", :with => "newpassword"
  fill_in "user_password_confirmation", :with => "newpassword"
  fill_in "user_current_password", :with => @user_info[:password]
end

When(/^I edit my password with missing confirmation$/) do
  click_link "Edit account"
  fill_in "user_password", :with => "newpassword"
  fill_in "user_current_password", :with => @user_info[:password]
end

When(/^I edit my password with missmatched confirmation$/) do
  click_link "Edit account"
  fill_in "user_password", :with => "newpassword"
  fill_in "user_password_confirmation", :with => "newpassword123"
  fill_in "user_current_password", :with => @user_info[:password]
end

When /^I look at the list of users$/ do
  visit '/'
end

### THEN ###
Then /^I should be signed in$/ do
  page.should_not have_content "Sign up"
  page.should have_content "Welcome Back"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "login"
  page.should_not have_content "logout"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid Email or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then(/^I should see a current password missing message$/) do
  page.should have_content "Current password can't be blank"
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:name]
end

def http_delete path
  current_driver = Capybara.current_driver
  Capybara.current_driver = :rack_test
  page.driver.submit :delete, path, {}
  Capybara.current_driver = current_driver
end