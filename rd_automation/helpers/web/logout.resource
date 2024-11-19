*** Settings ***
Resource    ${EXECDIR}/rd_automation/helpers/web/selenium.resource
Resource    ${EXECDIR}/rd_automation/elements/web/navbar.resource
Resource    ${EXECDIR}/rd_automation/elements/web/login.resource


*** Keywords ***
Logout RD
    Wait And Click Element    element=${navbar.span_username}
    Wait And Click Element    element=${navbar.li_logout}
    Wait Element    element=${login.input_username}
