*** Settings ***
Resource    ${EXECDIR}/rd_automation/resources/mobile.resource
Resource    ${EXECDIR}/rd_automation/helpers/mobile/appium.resource
Resource    ${EXECDIR}/rd_automation/elements/mobile/login.resource


*** Variables ***
${USER}     ${EMPTY}


*** Keywords ***
the user is on the "Login" page
    Wait Element    element=${login.text_email}
    Wait Element    element=${login.text_password}

the user enters an invalid username and password
    ${email}    FakerLibrary.Email
    ${password}    FakerLibrary.Password

    Wait And Input Text    element=${login.text_email}    text=Invalid${email}
    Wait And Input Text    element=${login.text_password}    text=Invalid${password}

the user enters a valid username and password
    Wait And Input Text    element=${login.text_email}    text=${USER.EMAIL}
    Wait And Input Text    element=${login.text_password}    text=${USER.PASSWORD}

clicks the login button
    Wait And Click Element    element=${login.button_login}

an error message "Login Error" is displayed
    Log RD    warning    Element without valid mapping
    # Wait Element    element=${login.text_toast_login_error}

clicks the new user button
    Wait And Click Element    element=${login.text_register}
