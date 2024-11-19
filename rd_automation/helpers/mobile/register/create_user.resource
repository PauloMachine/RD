*** Settings ***
Resource    ${EXECDIR}/rd_automation/steps/mobile/register.resource
Resource    ${EXECDIR}/rd_automation/steps/mobile/login.resource


*** Keywords ***
Create User
    Run Keyword    clicks the new user button
    Run Keyword    the user is on the "Register" page
    Run Keyword    the user enters a valid user
    Run Keyword    clicks the register button
    Run Keyword    the user has successfully registered in
