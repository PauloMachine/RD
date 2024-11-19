*** Comments ***
This test suite is designed to validate the login process in a mobile application.
The tests ensure that both valid and invalid credentials are handled properly by the application.
The suite is structured to test login scenarios with valid and invalid inputs, ensuring the system
displays the correct response for each case.


*** Settings ***
Resource        ${EXECDIR}/rd_automation/helpers/mobile/register/create_user.resource
Resource        ${EXECDIR}/rd_automation/helpers/mobile/appium.resource
Resource        ${EXECDIR}/rd_automation/steps/mobile/login.resource
Resource        ${EXECDIR}/rd_automation/steps/mobile/home.resource

Test Tags       mobile    login


*** Test Cases ***
Login with invalid credentials
    [Documentation]
    ...    Validate the application's behavior
    ...    when the user enters invalid credentials
    [Tags]    tc0001
    Given the user is on the "Login" page
    When the user enters an invalid username and password
    And clicks the login button
    Then an error message "Login Error" is displayed

Login with valid credentials
    [Documentation]
    ...    Validate the application's behavior
    ...    when the user enters valid credentials
    [Tags]    tc0002
    [Setup]    Create User
    Given the user is on the "Login" page
    When the user enters a valid username and password
    And clicks the login button
    Then the user is successfully logged in
