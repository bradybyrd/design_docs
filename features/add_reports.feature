Feature: Reports are added to the application via api upload
As a EDI user, I perform analysis in Excel, then click the upload button
which generates pdfs from the print areas in the workbook and
uploads them to the rest api

Scenario: upload a document to the api with valid credentials
  Given the standard company exists
  Given I exist as an edi user with an engineer role
  When I upload a document as a post to "/api/uploads"
  When I sign in as a customer with valid credentials
  When I visit the home page
  Then I should see the new report