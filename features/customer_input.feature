
Feature: Dashboard sites display

Scenario: From application dashboard click on a site
Given there is a company named "Our Municipality"
Given I am logged in as "johnq.public@megacorp.com" with password "kittens4me"
When I am on the "dashboard" page
Then I should see the site "Site Name_"