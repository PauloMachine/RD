*** Settings ***
Resource    ${EXECDIR}/rd_automation/resources/mobile.resource
Resource    ${EXECDIR}/rd_automation/helpers/mobile/appium.resource
Resource    ${EXECDIR}/rd_automation/elements/mobile/register.resource


*** Variables ***
${USER}     ${EMPTY}


*** Keywords ***
the user is on the "Register" page
    Wait Element    element=${register.text_register_name}
    Wait Element    element=${register.text_register_phone_number}
    Wait Element    element=${register.text_register_gmail}
    Wait Element    element=${register.text_register_password}
    Wait Element    element=${register.button_register}

the user enters a valid user
    Run Keyword    Create User Data

    Wait And Input Text    element=${register.text_register_name}    text=${USER.NAME}
    Wait And Input Text    element=${register.text_register_phone_number}    text=${USER.PHONE_NUMBER}
    Wait And Input Text    element=${register.text_register_gmail}    text=${USER.EMAIL}
    Wait And Input Text    element=${register.text_register_password}    text=${USER.PASSWORD}

clicks the register button
    Wait And Click Element    element=${register.button_register}

the user has successfully registered in
    Log RD    warning    Element without valid mapping
    # Wait Element    element=${register.text_toast_login_successful}
    Wait And Click Element    element=${register.button_go_to_login}

Create User Data
    ${name}    FakerLibrary.Name
    ${phone_number}    FakerLibrary.Phone Number
    ${email}    FakerLibrary.Email
    ${password}    FakerLibrary.Password

    ${user}    Create Dictionary
    ...    NAME=${name}
    ...    PHONE_NUMBER=${phone_number}
    ...    EMAIL=${email}
    ...    PASSWORD=${password}

    VAR    ${USER}    ${user}    scope=TEST
