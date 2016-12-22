
Feature: Dashboard sites display

Scenario: From application dashboard click on a site
Given there is a company named "Our Municipality"
Given I am logged in as "johnq.public@megacorp.com" with password "kittens4me"
When I am on the "dashboard" page
Then I should see the site "Site Name_"

Scenario: Basic behavior of the site form
Given I am a reporter from a cusomter company
Given I am on the dashboard page
When I click on a site I should be presented with the site form
When I click on a toggle areas the form expands to show fields for that area
When I click on a toggle area all other areas collapse

Scenario: A reporter from a customer company should easily be able to enter their site data
When I have toggled the site basics form
Then I should be able to edit the zone name
Then I should have a link to "Add Zone"
Then I should have a plus icon to add a Basin to the zone
Then I should have a drop down to select unit
When I select "Metric" from the units drop down
and I click on the "Site Climate and Conditions" toggle 
Then I should see units such as "feet" and "psi"
Given I have created a Zone named "Zone1" and a Basin named "Tank 1" in the zone
Then I should see a section named "Tank 1 - Basin Geometry (zone: Zone1)"
When I click on the "Tank 1 - Basin Geometry (zone: Zone1)" toggle

