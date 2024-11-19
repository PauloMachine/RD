*** Settings ***
Resource    ${EXECDIR}/rd_automation/steps/web/admin.resource


*** Keywords ***
Search Admin User
    Run Keyword    I search for "Admin User"
    Run Keyword    the system should display the "Admin User"
