*** Settings ***
Resource    ${EXECDIR}/rd_automation/resources/mobile.resource
Resource    ${EXECDIR}/rd_automation/helpers/mobile/appium.resource
Resource    ${EXECDIR}/rd_automation/elements/mobile/home.resource


*** Keywords ***
the user is successfully logged in
    Wait Element    element=${home.text_logged_in}
