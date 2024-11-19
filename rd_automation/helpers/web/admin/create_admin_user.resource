*** Settings ***
Resource    ${EXECDIR}/rd_automation/steps/web/admin.resource


*** Keywords ***
Create Admin User
    Run Keyword    I am on the "Admin" page
    Run Keyword    I click on the "Add" button
    Run Keyword    I add a new "Admin User"
    Run Keyword    the system should display the new "Admin User"
