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

Scenario: Recent activity is properly scoped to user
Given there is a standard data load with the company "Mega Corp" and user email "remote_user@gmail.com"
Given there is a standard data load with the company "EDI" and user email "bradford.byrd@gmail.com"
Given the company "EDI" is the master company
When the user "bradford.byrd@gmail.com" has authenticated
Then I should see the all recent activity
When the user "remote_user@gmail.com" has authenticated
Then I should see only recent activity for "Mega Corp"

Scenario: Master company engineers can impersonate other companies
Given there is a standard data load with the company "Mega Corp" and user email "remote_user@gmail.com"
Given there is a standard data load with the company "EDI" and user email "bradford.byrd@gmail.com"
Given the company "EDI" is the master company
When the user "bradford.byrd@gmail.com" has authenticated
Then I should see the phrase "Impersonate company"

Scenario: As a standard user uploaded reports from the rest api appear on the dashboard scoped to my company

Scenario: As a master company engineer or admin I have special access
Given My cookies have been cleared
When I login
Then I should be in the master company
Then I should see all recent activity
Then I should see all recent uploads
Then I should see the phrase "Impersonate company"
When I impersonate another company
Then uploaded reports should show for the impersonated company



