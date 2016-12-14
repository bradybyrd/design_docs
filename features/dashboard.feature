Feature: Dashboard sites display
The dashboard should be the landing page after logging in
It should have a section displaying the sites of the company the user belongs to

Scenario: Validate sites on the dashboard
Given there is a standard data load with the company "Mega Corp" and user email "bradford.byrd@gmail.com"
and the user "bradford.byrd@gmail.com" has authenticated
When I login as the standard user
Then I should see the "Site1 Company1" site

Scenario: Validate sites from other companies do not show on the dashboard
Given there is a site named "Site Company2"
and the standard user has authenticated
When I login as the standard user
Then I should see the "Pease Industrial Park" site