Feature: Account Creation and Deletion on Salesforce.com

Scenario: Create and delete accounts from datasheet       
	Given I am on the salesforce login page
	When I enter my credentials
	Then I expect to see the dashboard
	When I create new accounts
	And the accounts are deleted
	Then I will not see any of the accounts on the account page or via search